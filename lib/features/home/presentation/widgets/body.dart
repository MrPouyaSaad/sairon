import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/category/presentation/widgets/category_list.dart';
import 'package:sairon/features/home/presentation/bloc/home_bloc.dart';
import 'package:sairon/features/product/presentation/widgets/product_horizontal_list.dart';
import 'package:sairon/features/slider/presentation/widgets/slider.dart';
import '../widgets/appbar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientHeader(),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const LoadingIndicator();
            } else if (state is HomeError) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<HomeBloc>().add(LoadHomeData()),
              );
            } else if (state is HomeLoaded) {
              return ListView(
                children: [
                  if (state.topProducts.isNotEmpty)
                    ProductHorizontalList(
                      title: 'پرتخفیف‌ها',
                      products: state.topProducts,
                    ).marginOnly(top: 16),
                  if (state.banners.isNotEmpty)
                    BannerSlider(banners: state.banners).marginAll(16),
                  CategoryList(categoryList: state.categories),
                  if (state.recommendedProducts.isNotEmpty)
                    ProductHorizontalList(
                      title: 'محصولات پیشنهادی',
                      products: state.recommendedProducts,
                    ),
                  if (state.bestSellers.isNotEmpty)
                    ProductHorizontalList(
                      title: 'پرفروش‌ترین‌ها',
                      products: state.bestSellers,
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
