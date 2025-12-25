// widgets/phone_number_field.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sairon/core/themes/app_colors.dart';

class PhoneNumberField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final TextEditingController? controller;

  const PhoneNumberField({
    super.key,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.controller,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _controller;
  String? _validationError;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return 'لطفاً شماره موبایل را وارد کنید';
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.startsWith('0')) {
      if (cleaned.length != 11) {
        return 'شماره موبایل باید ۱۱ رقم باشد (با صفر)';
      }
      if (!cleaned.startsWith('09')) {
        return 'شماره موبایل باید با ۰۹ شروع شود';
      }
    } else {
      if (cleaned.length != 10) {
        return 'شماره موبایل باید ۱۰ رقم باشد (بدون صفر)';
      }
      if (!cleaned.startsWith('9')) {
        return 'شماره موبایل باید با ۹ شروع شود';
      }
    }

    return null;
  }

  void _onChanged(String value) {
    final validationError = _validatePhone(value);
    setState(() {
      _validationError = validationError;
    });

    if (validationError == null) {
      final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
      final formattedPhone = cleaned.startsWith('0') ? cleaned : '0$cleaned';
      widget.onChanged?.call(formattedPhone);
    } else {
      widget.onChanged?.call('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'شماره موبایل',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundColor,
            wordSpacing: -1,
          ),
        ),
        const Gap(8),
        TextField(
          controller: _controller,
          enabled: widget.enabled,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: '9123456789',
            hintTextDirection: TextDirection.rtl,
            alignLabelWithHint: true,
            hintStyle: const TextStyle(color: Colors.grey),
            errorText: _validationError ?? widget.errorText,
            errorStyle: TextStyle(backgroundColor: AppColors.backgroundColor),
            suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 1, height: 20, color: Colors.grey[300]),
                  const SizedBox(width: 8),
                  Text(
                    '98+',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          onChanged: _onChanged,
        ),
      ],
    );
  }

  String _getFormattedPhoneForServer() {
    final cleaned = _controller.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.startsWith('0')) {
      return cleaned;
    }
    return '0$cleaned';
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
