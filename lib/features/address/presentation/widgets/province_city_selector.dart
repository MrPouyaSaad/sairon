import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProvinceCitySelector extends StatefulWidget {
  final Function(Map<String, dynamic>?, Map<String, dynamic>?)? onChanged;
  final Function(String)? onProvinceChanged;
  final Function(String)? onCityChanged;
  final String? selectedProvince;
  final String? selectedCity;

  const ProvinceCitySelector({
    super.key,
    this.onChanged,
    this.onProvinceChanged,
    this.onCityChanged,
    this.selectedProvince,
    this.selectedCity,
  });

  @override
  State<ProvinceCitySelector> createState() => _ProvinceCitySelectorState();
}

class _ProvinceCitySelectorState extends State<ProvinceCitySelector> {
  List<Map<String, dynamic>> _provinces = [];
  List<Map<String, dynamic>> _cities = [];

  Map<String, dynamic>? selectedProvince;
  Map<String, dynamic>? _selectedCity;

  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final provincesData = await rootBundle.loadString(
        'assets/data/ostan.json',
      );

      final citiesData = await rootBundle.loadString('assets/data/shahr.json');

      setState(() {
        _provinces = List<Map<String, dynamic>>.from(
          json.decode(provincesData),
        );
        _cities = List<Map<String, dynamic>>.from(json.decode(citiesData));
        _isDataLoaded = true;
      });

      if (widget.selectedProvince != null) {
        _setInitialValues();
      }
    } catch (e) {
      debugPrint('❌ Error loading data: $e');
    }
  }

  void _setInitialValues() {
    if (widget.selectedProvince != null && _provinces.isNotEmpty) {
      selectedProvince = _provinces.firstWhere(
        (p) => p['name'] == widget.selectedProvince,
        orElse: () => _provinces.first,
      );
    }

    if (widget.selectedCity != null &&
        _cities.isNotEmpty &&
        selectedProvince != null) {
      final provinceCities = _getCitiesForProvince(selectedProvince!['id']);
      _selectedCity = provinceCities.firstWhere(
        (c) => c['name'] == widget.selectedCity,
        orElse: () => provinceCities.isNotEmpty ? provinceCities.first : {},
      );
    }
  }

  List<Map<String, dynamic>> _getCitiesForProvince(int provinceId) {
    return _cities.where((city) => city['ostan'] == provinceId).toList();
  }

  void _onProvinceChanged(Map<String, dynamic>? province) {
    setState(() {
      selectedProvince = province;
      _selectedCity = null;
    });
    widget.onChanged?.call(selectedProvince, _selectedCity);
    widget.onProvinceChanged?.call(province?['name'] ?? '');
  }

  void _onCityChanged(Map<String, dynamic>? city) {
    setState(() {
      _selectedCity = city;
    });
    widget.onChanged?.call(selectedProvince, _selectedCity);
    widget.onCityChanged?.call(city?['name'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDataLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        DropdownSearch<Map<String, dynamic>>(
          items: (filter, loadProps) => _provinces,
          itemAsString: (item) => item['name']?.toString() ?? '',
          selectedItem: selectedProvince,
          compareFn: (a, b) => a['id'] == b['id'],
          onChanged: _onProvinceChanged,
          popupProps: PopupProps.modalBottomSheet(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: 'جستجو در استان‌ها...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              label: Text.rich(
                TextSpan(
                  text: 'استان',
                  children: [
                    TextSpan(
                      text: '  *',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'استان خود را انتخاب کنید',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(Icons.location_city, color: Colors.grey[600]),
            ),
          ),
        ),

        const SizedBox(height: 20),

        DropdownSearch<Map<String, dynamic>>(
          items: (filter, loadProps) => (selectedProvince == null)
              ? []
              : _getCitiesForProvince(selectedProvince!['id']),
          enabled: selectedProvince != null,
          itemAsString: (item) => item['name']?.toString() ?? '',
          compareFn: (a, b) => a['id'] == b['id'],
          selectedItem: _selectedCity,
          onChanged: _onCityChanged,
          popupProps: PopupProps.modalBottomSheet(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: 'جستجو در شهرها...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'انتخاب شهر',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              label: Text.rich(
                TextSpan(
                  text: 'شهر',
                  children: [
                    TextSpan(
                      text: selectedProvince != null
                          ? '  *'
                          : '    (ابتدا استان را انتخاب نمایید)',
                      style: selectedProvince != null
                          ? TextStyle(
                              color: Colors.red[400],
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ],
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
              hintText: selectedProvince != null
                  ? 'شهر خود را انتخاب کنید'
                  : 'ابتدا استان را انتخاب کنید',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(Icons.location_on, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }
}
