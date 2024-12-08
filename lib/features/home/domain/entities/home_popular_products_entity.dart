class HomePopularProductsEntity {
  final int? id;
  final String? title;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final String? thumbnail;
  final double? rating;

  const HomePopularProductsEntity(
      {required this.id,
      required this.title,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.thumbnail,
      required this.rating});
}
