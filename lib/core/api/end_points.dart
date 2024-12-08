abstract class EndPoints {
  static const String baseUrl = 'https://dummyjson.com/';
  static const String categories = 'c/5a78-bb55-496e-9a7c';
  static const String popularProducts = 'c/6ef7-8b8d-48b4-82f7';
  static const String allProducts = 'products';
  static String categoryProducts(String category) =>
      'products/category/$category';

  static String getProductById(String productId) => 'products/$productId';

  static String searchProducts(String? query) => 'products/search?q=$query';
}
