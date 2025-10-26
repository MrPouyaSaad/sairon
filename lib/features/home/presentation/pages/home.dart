import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/category/presentation/widgets/category_list.dart';
import 'package:sairon/features/home/presentation/bloc/home_bloc.dart';
import 'package:sairon/features/product/data/repositories/product_repository_impl.dart';
import 'package:sairon/features/product/presentation/widgets/product_horizontal_list.dart';
import '../../../category/data/repositories/category_repository_impl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(
          productRepository: productRepository,
          categoryRepository: categoryRepository,
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
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return ProductHorizontalList(
                          title: 'پرتخفیف‌ها',
                          products: state.topProducts,
                        );

                      case 1:
                        return CategoryList(categoryList: state.categories);
                      case 2:
                        return ProductHorizontalList(
                          title: 'جدیدترین محصولات',
                          products: state.newArrivals,
                        );
                      case 3:
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
