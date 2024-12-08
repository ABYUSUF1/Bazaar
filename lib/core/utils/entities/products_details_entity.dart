import '../models/products_details_model/product.dart';

class ProductsDetailsEntity {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductsDetailsEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}





// class ProductsDetailsEntity {
//   final int? id;
//   final String? title;
//   final String? description;
//   final String? category;
//   final double? price;
//   final double? discountPercentage;
//   final double? rating;
//   final int? stock;
//   final List? tags;
//   final String? brand;
//   final String? sku;
//   final int? weight;
//   final Dimensions? dimensions;
//   final String? warrantyInformation;
//   final String? shippingInformation;
//   final String? availabilityStatus;
//   final List<Review>? reviews;
//   final String? returnPolicy;
//   final int? minimumOrderQuantity;
//   final Meta? meta;
//   final List? images;
//   final String? thumbnail;

//   ProductsDetailsEntity({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.category,
//     required this.price,
//     required this.discountPercentage,
//     required this.rating,
//     required this.stock,
//     required this.tags,
//     required this.brand,
//     required this.sku,
//     required this.weight,
//     required this.dimensions,
//     required this.warrantyInformation,
//     required this.shippingInformation,
//     required this.availabilityStatus,
//     required this.reviews,
//     required this.returnPolicy,
//     required this.minimumOrderQuantity,
//     required this.meta,
//     required this.images,
//     required this.thumbnail,
//   });
// }
