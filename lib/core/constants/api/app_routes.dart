// app_routes.dart

class AppRoutes {
  // ============ AUTH ROUTES ============
  static const AuthRoutes auth = AuthRoutes();

  // ============ CONTENT ROUTES ============
  static const ContentRoutes content = ContentRoutes();

  // ============ CATEGORIES ROUTES ============
  static const CategoryRoutes categories = CategoryRoutes();

  // ============ PRODUCTS ROUTES ============
  static const ProductRoutes products = ProductRoutes();

  // ============ CART ROUTES ============
  static const CartRoutes cart = CartRoutes();

  // ============ USER PROFILE ROUTES ============
  static const ProfileRoutes profile = ProfileRoutes();

  // ============ ORDERS ROUTES ============
  static const OrderRoutes orders = OrderRoutes();

  // ============ PAYMENT ROUTES ============
  static const PaymentRoutes payment = PaymentRoutes();
}

//! ------------------------------------------

class AuthRoutes {
  const AuthRoutes();

  final String requestCode = '/api/auth/request-code';
  final String verifyCode = '/api/auth/verify-code';
  final String login = '/api/auth/login';
  final String logout = '/api/auth/logout';
}

class ContentRoutes {
  const ContentRoutes();

  final String slider = '/api/content/slider';
}

class CategoryRoutes {
  const CategoryRoutes();

  final String base = '/api/categories';
}

class ProductRoutes {
  const ProductRoutes();

  final String all = '/api/products/all';
  final String byLabel = '/api/products/label';
  final String search = '/api/products/search';
  final String byCategory = '/api/products/category';

  String details(String id) => '/api/products/$id';
  String recommended(String productId) =>
      '/api/products/$productId/recommended';
}

class CartRoutes {
  const CartRoutes();

  final String base = '/api/cart';
  final String add = '/api/cart/add';
  final String update = '/api/cart/update';
  final String clear = '/api/cart/clear';

  String remove(String productId) => '/api/cart/remove/$productId';
}

class ProfileRoutes {
  const ProfileRoutes();

  final String base = '/api/user/profile';
  final String addresses = '/api/user/addresses';

  String addressDetails(String addressId) => '/api/user/addresses/$addressId';
  String setDefaultAddress(String addressId) =>
      '/api/user/addresses/$addressId/default';
}

class OrderRoutes {
  const OrderRoutes();

  final String base = '/api/orders';
  final String stats = '/api/orders/stats';

  String details(String orderId) => '/api/orders/$orderId';
  String cancel(String orderId) => '/api/orders/$orderId/cancel';
}

class PaymentRoutes {
  const PaymentRoutes();

  final String create = '/api/payments/create';
  final String samanVerify = '/api/payments/saman/verify';
  final String samanReverse = '/api/payments/saman/reverse';
}
