import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sairon/features/cart/presentation/pages/cart_flow.dart';
import '../../../home/presentation/pages/home.dart';
import '../bloc/root_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = [
      GlobalKey<NavigatorState>(), // Home
      GlobalKey<NavigatorState>(), // Cart
      GlobalKey<NavigatorState>(), // Profile
    ];

    return BlocProvider(
      create: (_) => RootBloc(),
      child: BlocConsumer<RootBloc, RootState>(
        listener: (context, state) {
          if (state.showExitWarning) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("برای خروج دوبار دکمه برگشت را بزنید!"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              final navigator = keys[state.selectedIndex].currentState!;
              if (navigator.canPop()) {
                navigator.pop();
                return false;
              } else {
                context.read<RootBloc>().add(const BackButtonPressed());
                return false;
              }
            },
            child: Scaffold(
              body: IndexedStack(
                index: state.selectedIndex,
                children: [
                  _buildNavigator(keys[0], HomeScreen()),
                  _buildNavigator(keys[1], CartFlowScreen()),
                  _buildNavigator(keys[2], HomeScreen()),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  wordSpacing: -2,
                  letterSpacing: -0.5,
                ),

                currentIndex: state.selectedIndex,
                onTap: (index) {
                  context.read<RootBloc>().add(ChangeTab(index));
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'سبد خرید',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'پروفایل',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigator(GlobalKey key, Widget child) {
    return Navigator(
      key: key,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
    );
  }
}
