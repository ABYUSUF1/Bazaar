import '../../../domain/entities/home_categories_entity.dart';
import 'localized_title.dart';

class HomeGetAllCategoriesModel {
  int? id;
  LocalizedTitle? localizedTitle;
  String? slug;
  String? imageUrl;

  HomeGetAllCategoriesModel({
    this.id,
    this.localizedTitle,
    this.slug,
    this.imageUrl,
  });

  factory HomeGetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    return HomeGetAllCategoriesModel(
      id: json['id'] as int?,
      localizedTitle: json['localizedTitle'] == null
          ? null
          : LocalizedTitle.fromJson(
              json['localizedTitle'] as Map<String, dynamic>),
      slug: json['slug'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'localizedTitle': localizedTitle?.toJson(),
        'slug': slug,
        'image_url': imageUrl,
      };

  HomeCategoriesEntity toEntity() {
    return HomeCategoriesEntity(
      id: id!,
      localizedTitle: localizedTitle!,
      slug: slug!,
      imageUrl: imageUrl!,
    );
  }
}
