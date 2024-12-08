import '../../entities/products_details_entity.dart';
import 'product.dart';

class ProductsDetailsModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsDetailsModel({this.products, this.total, this.skip, this.limit});

  factory ProductsDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('products')) {
      // JSON with multiple products
      return ProductsDetailsModel(
        products: (json['products'] as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int?,
        skip: json['skip'] as int?,
        limit: json['limit'] as int?,
      );
    } else {
      // JSON with a single product
      return ProductsDetailsModel(
        products: [Product.fromJson(json)],
        total: 1,
        skip: 0,
        limit: 1,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'products': products?.map((e) => e.toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };

  ProductsDetailsEntity toEntity() {
    return ProductsDetailsEntity(
      products: products,
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}
