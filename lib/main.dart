import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_theme.dart';
import 'package:sairon/features/home/presentation/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sairon Store',
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: HomeScreen(),
    );
  }
}
