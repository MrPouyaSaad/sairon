import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sairon/core/themes/app_theme.dart';
import 'package:sairon/features/root/presentation/pages/root.dart';

import 'features/auth/data/repositories/token_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenRepository.loadToken();
  runApp(MyApp());
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
