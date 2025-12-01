import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/core/widgets/error_widget.dart';
import 'package:sairon/core/widgets/loading_indicator.dart';
import 'package:sairon/features/auth/data/repositories/token_repo.dart';
import 'package:sairon/features/cart/domain/usecase/cart_usecases.dart';
import 'package:sairon/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_list.dart';
import 'package:sairon/features/cart/presentation/widgets/cart_total.dart';
import 'package:sairon/features/cart/presentation/widgets/empty_cart_screen.dart';
import '../../../../core/constants/app_constants.dart' show Constants;
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/login_promt_screen.dart';
import '../../data/repository/cart_repository_impl.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<String?>(
        valueListenable: TokenRepository.tokenNotifier,
        builder: (context, token, child) {
          if (!TokenRepository.isLoggedIn) {
            return LoginPromtScreen(
              description:
                  'برای مشاهده سبد خرید و ادامه فرآیند خرید، لطفاً وارد حساب کاربری خود شوید!',
            );
          } else {
            return BlocProvider(
              create: (context) {
                final bloc = CartBloc(CartUsecases(repository: cartRepository));
                bloc.add(CartStarted());
                return bloc;
              },
              child: SafeArea(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading || state is CartInitial) {
                      return ScreenLoadingIndicator();
                    } else if (state is CartError) {
                      return AppErrorWidget(
                        message: state.message,
                        onRetry: () {
                          BlocProvider.of<CartBloc>(context).add(CartStarted());
                        },
                      );
                    } else if (state is CartLoaded) {
                      if (state.cart!.items.isEmpty) {
                        return EmptyCartScreen();
                      } else {
                        return Stack(
                          children: [
                            ListView.separated(
                              itemCount: 2, // CartItemList , CartTotalWidget
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return CartItemList(items: state.cart!.items);
                                } else {
                                  return CartTotalWidget(cart: state.cart!);
                                }
                              },
                            ),
                            Positioned(
                              bottom: 16,
                              left: 24,
                              right: 24,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed('/checkout');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: Constants.primaryRadius,
                                    ),
                                  ),
                                  child: const Text(
                                    'ادامه خرید',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      throw 'مشکلی در بارگیری این صفح رخ داد!';
                    }
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
