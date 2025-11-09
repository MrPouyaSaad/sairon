import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProvinceCitySelector extends StatefulWidget {
  final Function(Map<String, dynamic>?, Map<String, dynamic>?)? onChanged;

  const ProvinceCitySelector({super.key, this.onChanged});

  @override
  State<ProvinceCitySelector> createState() => _ProvinceCitySelectorState();
}

class _ProvinceCitySelectorState extends State<ProvinceCitySelector> {
  List<Map<String, dynamic>> _provinces = [];
  List<Map<String, dynamic>> _cities = [];

  Map<String, dynamic>? _selectedProvince;
  Map<String, dynamic>? _selectedCity;

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
      });
    } catch (e) {
      debugPrint('❌ Error loading data: $e');
    }
  }

  List<Map<String, dynamic>> _getCitiesForProvince(int provinceId) {
    return _cities.where((city) => city['ostan'] == provinceId).toList();
  }

  void _onProvinceChanged(Map<String, dynamic>? province) {
    setState(() {
      _selectedProvince = province;
      _selectedCity = null;
    });
    widget.onChanged?.call(_selectedProvince, _selectedCity);
  }

  void _onCityChanged(Map<String, dynamic>? city) {
    setState(() {
      _selectedCity = city;
    });
    widget.onChanged?.call(_selectedProvince, _selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<Map<String, dynamic>>(
          items: (filter, loadProps) => _provinces,
          itemAsString: (item) => item['name']?.toString() ?? '',
          selectedItem: _selectedProvince,
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
            title: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'انتخاب استان',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'استان',
              hintText: 'استان خود را انتخاب کنید',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.location_city),
            ),
          ),
        ),

        const SizedBox(height: 20),

        DropdownSearch<Map<String, dynamic>>(
          items: (filter, loadProps) => (_selectedProvince == null)
              ? []
              : _getCitiesForProvince(_selectedProvince!['id']),

          enabled: _selectedProvince != null,
          itemAsString: (item) => item['name']?.toString() ?? '',
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
              labelText: 'شهر',
              hintText: _selectedProvince != null
                  ? 'شهر خود را انتخاب کنید'
                  : 'ابتدا استان را انتخاب کنید',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.location_on),
            ),
          ),
        ),
      ],
    );
  }
}
