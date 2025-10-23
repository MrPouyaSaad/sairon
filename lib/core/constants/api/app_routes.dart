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

  final String categories = '/api/categories';
}

class ProductRoutes {
  const ProductRoutes();

  String all({int page = 1, int limit = 10}) =>
      '/api/products/all?page=$page&limit=$limit';

  String byLabel({required String label, int page = 1, int limit = 10}) =>
      '/api/products/label?label=$label&page=$page&limit=$limit';

  String byCategory({required int categoryId, int page = 1, int limit = 10}) =>
      '/api/products/category?categoryId=$categoryId&page=$page&limit=$limit';

  String search({required String query, int page = 1, int limit = 10}) =>
      '/api/products/search?q=$query&page=$page&limit=$limit';

  String byId(int id) => '/api/products/$id';

  String recommended(int productId, {int page = 1, int limit = 10}) =>
      '/api/products/$productId/recommended?page=$page&limit=$limit';
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
