// lib/core/widgets/app_textfield.dart
import 'package:flutter/material.dart';
import 'package:sairon/core/constants/app_constants.dart';

class ModernTextField extends StatelessWidget {
  const ModernTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isRequired,
    this.keyboardType = TextInputType.text,
    this.title,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final String? title;
  final IconData icon;
  final bool isRequired;
  final TextInputType keyboardType;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: Constants.primaryButtonHeight,
          padding: const EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            color: enabled ? Colors.grey[50] : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  icon,
                  size: 20,
                  color: enabled ? Colors.grey[600] : Colors.grey[400],
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.center,
                  enabled: enabled,
                  validator: validator,
                  onChanged: onChanged,

                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    errorStyle: const TextStyle(height: 0.5, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (validator != null)
          Container(
            height: 36,
            padding: const EdgeInsets.only(top: 4, right: 8),
            child: Builder(
              builder: (context) {
                final errorText = validator!(controller.text);
                if (errorText != null && errorText.isNotEmpty) {
                  return Text(
                    errorText,
                    style: TextStyle(
                      wordSpacing: -1,
                      color: Colors.red[600],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
      ],
    );
  }
}
