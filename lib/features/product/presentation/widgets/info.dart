import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sairon/core/widgets/gradient.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/variants.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  late Map<String, String> _selectedAttributes;
  ProductVariantEntity? _selectedVariant;

  @override
  void initState() {
    super.initState();
    _initializeSelectedAttributes();
    _selectBestVariant();
  }

  void _initializeSelectedAttributes() {
    final variants = widget.productEntity.variants;
    if (variants.isEmpty) {
      _selectedAttributes = {};
      return;
    }

    final cheapestVariant = variants.reduce((a, b) {
      final pa = double.tryParse(a.price) ?? 0;
      final pb = double.tryParse(b.price) ?? 0;
      return pa < pb ? a : b;
    });

    _selectedAttributes = Map<String, String>.from(cheapestVariant.attributes);
    _selectedVariant = cheapestVariant;
  }

  void _selectBestVariant() {
    final variants = widget.productEntity.variants;

    if (variants.isEmpty) {
      _selectedVariant = null;
      return;
    }

    final matched = variants.firstWhereOrNull(
      (v) => _selectedAttributes.entries.every(
        (e) => v.attributes[e.key] == e.value,
      ),
    );

    _selectedVariant =
        matched ??
        variants.reduce((a, b) {
          final pa = double.tryParse(a.price) ?? 0;
          final pb = double.tryParse(b.price) ?? 0;
          return pa < pb ? a : b;
        });
  }

  void _onAttributeSelected(String key, String value) {
    setState(() {
      _selectedAttributes[key] = value;
      _selectBestVariant();
    });
  }

  String _getCurrentPrice() {
    final discountValue = double.tryParse(widget.productEntity.discount) ?? 0;
    final discountType =
        widget.productEntity.discountType; // "percent" or "amount"

    // پایه قیمت: اگر ورینت انتخاب شده از اون بگیر، وگرنه از خود محصول
    final basePrice =
        double.tryParse(
          _selectedVariant?.price ?? widget.productEntity.orginalPrice,
        ) ??
        0;

    if (discountValue == 0) return basePrice.toString();

    double finalPrice;

    if (discountType == 'percent') {
      finalPrice = basePrice * (1 - discountValue / 100);
    } else if (discountType == 'amount') {
      finalPrice = basePrice - discountValue;
    } else {
      finalPrice = basePrice;
    }

    // اطمینان از اینکه قیمت منفی نشه
    if (finalPrice < 0) finalPrice = 0;

    return finalPrice.toStringAsFixed(0);
  }

  bool get _hasDiscount =>
      (int.tryParse(widget.productEntity.discount) ?? 0) > 0;

  bool get _isInStock =>
      int.tryParse(_selectedVariant?.stock ?? '0') != null &&
      int.parse(_selectedVariant?.stock ?? '0') > 0;

  Map<String, Set<String>> get _attributesMap {
    final map = <String, Set<String>>{};
    for (final v in widget.productEntity.variants) {
      v.attributes.forEach((key, value) {
        map.putIfAbsent(key, () => <String>{}).add(value);
      });
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceSection(),
        const Gap(12),
        _titleSection(),
        const Gap(12),
        _stockSection(),
        Divider().marginSymmetric(vertical: 12),
        _variantSelector(),
        Divider().marginSymmetric(vertical: 12),
        _technicalSpecs(),
        Divider().marginSymmetric(vertical: 12),
        _description(),
      ],
    ).marginSymmetric(horizontal: 24);
  }

  Widget _priceSection() {
    final originalPrice =
        _selectedVariant?.price ?? widget.productEntity.orginalPrice;
    final discountedPrice = _getCurrentPrice();

    final hasDiscount = (int.tryParse(widget.productEntity.discount) ?? 0) > 0;

    return Row(
      children: [
        if (hasDiscount) _discountBadge(),
        if (hasDiscount) const Gap(8),
        if (hasDiscount)
          Text(
            originalPrice.formattedStringPrice.withPriceLable,
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (hasDiscount) const Gap(8),
        Text(
          discountedPrice.formattedStringPrice.withPriceLable,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _discountBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        gradient: GradientTheme.primaryGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '%${widget.productEntity.discount}',
        style: const TextStyle(
          color: AppColors.backgroundColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _titleSection() {
    return Text(
      widget.productEntity.name,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _stockSection() {
    return Row(
      children: [
        Icon(
          _isInStock ? Iconsax.verify5 : Iconsax.close_circle5,
          color: _isInStock ? Colors.green : Colors.redAccent,
          size: 20,
        ),
        const Gap(6),
        Text(
          _isInStock ? 'موجود در انبار' : 'ناموجود',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: _isInStock ? Colors.green : Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _variantSelector() {
    if (_attributesMap.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _attributesMap.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'انتخاب ${entry.key}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.value.map((val) {
                final selected = _selectedAttributes[entry.key] == val;
                return GestureDetector(
                  onTap: () => _onAttributeSelected(entry.key, val),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selected
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : AppColors.backgroundColor,
                      border: Border.all(
                        color: selected
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                        width: selected ? 2 : 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected)
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        if (selected) const SizedBox(width: 6),
                        Text(
                          val,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? AppColors.primaryColor
                                : AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const Gap(16),
          ],
        );
      }).toList(),
    );
  }

  Widget _technicalSpecs() {
    final attributes = widget.productEntity.attributes;
    if (attributes.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مشخصات فنی',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(8),
        ...attributes.map(
          (a) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(a.name, style: const TextStyle(fontSize: 14)),
                Text(
                  a.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'توضیحات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const Gap(8),
        Text(
          widget.productEntity.description,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
