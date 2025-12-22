import 'package:flutter/material.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/core/widgets/badge.dart';
import 'package:sairon/features/cart/data/repository/cart_repository_impl.dart';

import '../../../cart/presentation/pages/cart_flow.dart';
import '../../../home/presentation/pages/home.dart';
import '../../../profile/presentation/pages/profile_page.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.screen = homeIndex});
  final int screen;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  bool canPop = false;

  Future<bool> _onWillPop(bool isPop) async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return isPop;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return isPop;
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('برای خروج دوبار دکمه برگشت را بزنید!'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        canPop = true;
      });
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => setState(() {
          canPop = false;
        }),
      );
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    selectedScreenIndex = widget.screen;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopScope(
        canPop: canPop,
        onPopInvoked: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, const HomeScreen()),
              _navigator(_cartKey, cartIndex, const CartFlowScreen()),
              _navigator(_profileKey, profileIndex, const ProfilePage()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: AppColors.textSecondary,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
              BottomNavigationBarItem(
                icon: ValueListenableBuilder(
                  valueListenable: cartRepository.cartNotifier,
                  builder: (context, value, child) => SuperAnimatedBadge(
                    value: value == null ? 0 : value.totalQuantity,
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'پروفایل',
              ),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
                canPop = false;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}
