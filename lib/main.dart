import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sairon/core/themes/app_theme.dart';

import 'features/auth/data/repositories/token_repo.dart';
import 'features/cart/data/repository/cart_repository_impl.dart'
    show cartRepository;
import 'features/cart/domain/usecase/cart_usecases.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

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
    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    final mediaQueryData = MediaQuery.of(context);
    final constrainedTextScaleFactor = mediaQueryData.textScaler.clamp(
      minScaleFactor: 0.8,
      maxScaleFactor: 1,
    );
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaler: constrainedTextScaleFactor),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sairon Store',
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        home: BlocProvider(
          create: (_) =>
              SplashBloc(cartUsecase: CartUsecases(repository: cartRepository)),
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
