import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/gradient_appbar.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/category/domain/entities/category_entity.dart';
import 'package:sairon/features/product/data/repositories/product_repository_impl.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';
import 'package:sairon/features/product/presentation/bloc/product_bloc.dart';
import 'package:sairon/features/product/presentation/widgets/product_vertical_list.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.category});
  final CategoryEntity category; // Example category ID
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(ProductUseCases(productRepository))
            ..add(FetchProductsByCategory(categoryId: category.id)),
      child: Scaffold(
        body: Column(
          children: [
            GradientAppBar(
              title: category.name,
              height: 100,
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 20,
                left: 24,
                right: 24,
              ),
              textSize: 20,
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is FetchProductsLoading) {
                    return ScreenLoadingIndicator();
                  } else if (state is FetchProductsError) {
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () {},
                    );
                  } else if (state is FetchProductsSuccess) {
                    return SafeArea(
                      child: ProductVerticalList(products: state.products!),
                    );
                  } else {
                    throw 'مشکلی در بارگذاری صفحه پیش آمده است';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
