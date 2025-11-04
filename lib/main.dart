import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sairon/core/themes/app_theme.dart';
import 'package:sairon/features/root/presentation/pages/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sairon Store',
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: RootScreen(),
    );
  }
}
