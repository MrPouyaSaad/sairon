import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';

import '../themes/app_colors.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield({
    super.key,
    this.onChanged,
    required this.controller,
    required this.enabled,
    this.errorText,
    this.prefixIcon,
    this.sufixIcon,
    this.hintText,
    this.labelText,
  });
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final bool? enabled;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final String? hintText;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintTextDirection: TextDirection.rtl,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        errorText: errorText,
        errorStyle: TextStyle(backgroundColor: AppColors.backgroundColor),
        suffixIcon: sufixIcon,
        prefixIcon: prefixIcon,
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
      onChanged: onChanged,
    );
  }
}

class ModernTextField extends StatelessWidget {
  const ModernTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isRequired,
    this.keyboardType = TextInputType.text,
    this.title,
  });
  final TextEditingController controller;
  final String hintText;
  final String? title;
  final IconData icon;
  final bool isRequired;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isRequired) ...[
              Text(
                hintText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),

              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
        Container(
          height: Constants.primaryButtonHeight,
          padding: EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Icon(icon, size: 20, color: Colors.grey[600]),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
