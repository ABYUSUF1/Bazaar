import '../../data/models/home_get_all_categories_model/localized_title.dart';

class HomeCategoriesEntity {
  final int? id;
  final LocalizedTitle? localizedTitle;
  final String? slug;
  final String? imageUrl;

  HomeCategoriesEntity(
      {required this.id,
      required this.localizedTitle,
      required this.slug,
      required this.imageUrl});
}
