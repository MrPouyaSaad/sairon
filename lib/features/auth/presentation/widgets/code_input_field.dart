import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/themes/app_colors.dart';

class CodeInputField extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final ValueChanged<String> onCodeChanged;
  final int codeLength;

  const CodeInputField({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onCodeChanged,
    this.codeLength = 5,
  });

  @override
  State<CodeInputField> createState() => _CodeInputFieldState();
}

class _CodeInputFieldState extends State<CodeInputField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = widget.controllers;
    focusNodes = widget.focusNodes;
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      // همیشه به فیلد بعدی برو (چپ به راست)
      if (index < focusNodes.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
    }
    _notifyCodeChanged();
  }

  void _onBackspace(int index, String value) {
    if (value.isEmpty) {
      // اگر فیلد خالی است، به فیلد قبلی برو
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
        // فیلد قبلی را پاک کن
        controllers[index - 1].clear();
      }
    }
    _notifyCodeChanged();
  }

  void _notifyCodeChanged() {
    final code = controllers.map((e) => e.text).join();
    log("Code: $code");
    widget.onCodeChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    // بدون در نظر گرفتن RTL - همیشه چپ به راست
    return Directionality(
      textDirection: TextDirection.ltr, // اجبار به جهت چپ به راست
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.codeLength, (index) {
          return SizedBox(
            width: 48,
            height: 48,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  _onBackspace(index, controllers[index].text);
                }
              },
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.all(4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            ),
          );
        }),
      ),
    );
  }
}
