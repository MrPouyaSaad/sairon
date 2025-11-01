import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../category/data/repositories/category_repository_impl.dart';
import '../../../category/domain/usecases/category_usecases.dart';
import '../../../product/data/repositories/product_repository_impl.dart';
import '../../../product/domain/usecases/product_usecases.dart';
import '../../../slider/data/repositories/slider_repository_impl.dart';
import '../../../slider/domain/usecases/slider_usecases.dart';
import '../bloc/home_bloc.dart';
import '../widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          categoryUseCases: CategoryUseCases(repository: categoryRepository),
          productUseCases: ProductUseCases(productRepository),
          sliderUseCase: SliderUsecases(sliderRepositoryImpl: sliderRepository),
        );
        homeBloc.add(LoadHomeData());
        return homeBloc;
      },
      child: const HomeBody(),
    );
  }
}
