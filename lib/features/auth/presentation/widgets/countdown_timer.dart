// widgets/countdown_timer.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onResend;

  const CountdownTimer({super.key, this.initialSeconds = 60, this.onResend});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remainingSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (widget.onResend != null) {
      widget.onResend!();
      setState(() {
        _remainingSeconds = widget.initialSeconds;
      });
      _startTimer();
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingSeconds == 0) {
      return TextButton(
        onPressed: _resendCode,
        child: const Text(
          'ارسال مجدد',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Text(
      _formatTime(_remainingSeconds),
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
