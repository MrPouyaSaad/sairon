import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/product/data/repositories/product_repository_impl.dart';
import 'package:sairon/features/product/domain/usecases/product_usecases.dart';
import 'package:sairon/features/product/presentation/bloc/product_bloc.dart';
import 'package:sairon/features/product/presentation/widgets/product_horizontal_list.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductBloc(ProductUseCases(productRepository))
            ..add(FetchRecommendedProducts(productId: id)),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is FetchProductsLoading) {
                return ScreenLoadingIndicator();
              } else if (state is FetchProductsError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () {
                    BlocProvider.of<ProductBloc>(
                      context,
                    ).add(FetchRecommendedProducts(productId: id));
                  },
                );
              } else if (state is FetchProductsSuccess) {
                return state.products!.isEmpty
                    ? SizedBox()
                    : ProductHorizontalList(
                        title: 'محصولات پیشنهادی',
                        products: state.products,
                      );
              } else {
                throw 'مشکلی در بارگیری صفحه پیش آمد!';
              }
            },
          );
        },
      ),
    );
  }
}
