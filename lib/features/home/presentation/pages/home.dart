import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/category/domain/usecases/category_usecases.dart';
import 'package:sairon/features/category/presentation/widgets/category_list.dart';
import 'package:sairon/features/home/presentation/bloc/home_bloc.dart';
import 'package:sairon/features/product/data/repositories/product_repository_impl.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';
import 'package:sairon/features/product/presentation/widgets/product_horizontal_list.dart';
import 'package:sairon/features/slider/domain/usecases/slider_usecases.dart';
import 'package:sairon/features/slider/presentation/widgets/slider.dart';
import '../../../category/data/repositories/category_repository_impl.dart';
import '../../../slider/data/repositories/slider_repository_impl.dart';
import '../widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientHeader(),
      body: BlocProvider(
        create: (context) => HomeBloc(
          categoryUseCases: CategoryUseCases(repository: categoryRepository),
          productUseCases: ProductUseCases(productRepository),
          sliderUseCase: SliderUsecases(sliderRepositoryImpl: sliderRepository),
        )..add(LoadHomeData()),
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const LoadingIndicator();
              } else if (state is HomeError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () {
                    BlocProvider.of<HomeBloc>(context).add(LoadHomeData());
                  },
                );
              } else if (state is HomeLoaded) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return BannerSlider(
                          banners: state.banners,
                        ).marginAll(16);
                      case 1:
                        return ProductHorizontalList(
                          title: 'پرتخفیف‌ها',
                          products: state.topProducts,
                        );

                      case 2:
                        return CategoryList(categoryList: state.categories);
                      case 3:
                        return ProductHorizontalList(
                          title: 'جدیدترین محصولات',
                          products: state.newArrivals,
                        );
                      case 4:
                        return ProductHorizontalList(
                          title: 'پرفروش‌ترین‌ها',
                          products: state.bestSellers,
                        );

                      default:
                    }
                    return null;
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
