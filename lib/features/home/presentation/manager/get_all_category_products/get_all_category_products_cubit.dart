import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/features/home/domain/home_repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_all_category_products_state.dart';

class GetAllCategoryProductsCubit extends Cubit<GetAllCategoryProductsState> {
  GetAllCategoryProductsCubit(this._homeRepo)
      : super(GetAllCategoryProductsInitial());

  final HomeRepo _homeRepo;

  List<ProductsDetailsEntity> _originalCategoryProductsList = [];

  // Filters
  double _minPrice = 0;
  double _maxPrice = 2000;
  Set<String> _selectedBrands = {};
  double _currentRating = 1.0;

  // Sorting and display limit
  String _sortCriteria = 'Recommended';
  int _productDisplayLimit = 50;

  Future<void> getAllCategoryProducts({required String categorySlug}) async {
    emit(GetAllCategoryProductsLoading());
    final result =
        await _homeRepo.getCategoryProducts(categorySlug: categorySlug);
    result.fold(
      (failure) =>
          emit(GetAllCategoryProductsFailure(errMessage: failure.errMessage)),
      (categoryProductsList) {
        _originalCategoryProductsList = categoryProductsList;
        _emitFilteredAndSortedProducts(categoryProductsList);
      },
    );
  }

  void filterProducts() {
    emit(GetAllCategoryProductsLoading());

    final filteredProducts = _originalCategoryProductsList.where((entity) {
      final matchesPrice = entity.products!.any((product) =>
          product.price! >= _minPrice && product.price! <= _maxPrice);

      final matchesBrand = _selectedBrands.isEmpty
          ? true
          : entity.products!.any((product) =>
              product.brand != null && _selectedBrands.contains(product.brand));

      final matchesRating = entity.products!.any((product) =>
          product.rating != null && product.rating! >= _currentRating);

      return matchesPrice && matchesBrand && matchesRating;
    }).toList();

    _emitFilteredAndSortedProducts(filteredProducts);
  }

  void _emitFilteredAndSortedProducts(
      List<ProductsDetailsEntity> filteredProducts) {
    final sortedProducts = _sortProducts(filteredProducts);

    final limitedProducts = sortedProducts.take(_productDisplayLimit).toList();

    final limitedCount = limitedProducts.fold<int>(
      0,
      (count, entity) => count + (entity.products?.length ?? 0),
    );

    emit(GetAllCategoryProductsSuccess(
      categoryProductsList: limitedProducts,
      filteredProductCount: limitedCount,
      sortCriteria: _sortCriteria,
      productDisplayLimit: _productDisplayLimit, // Pass the display limit here
    ));
  }

  List<ProductsDetailsEntity> _sortProducts(
      List<ProductsDetailsEntity> products) {
    switch (_sortCriteria) {
      case 'PriceHighToLow':
        products.sort((a, b) {
          final aPrice =
              a.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
          final bPrice =
              b.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
          return bPrice.compareTo(aPrice);
        });
        break;
      case 'PriceLowToHigh':
        products.sort((a, b) {
          final aPrice =
              a.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
          final bPrice =
              b.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
          return aPrice.compareTo(bPrice);
        });
        break;
      case 'Rating':
        // Sort by rating from high to low
        products.sort((a, b) {
          final aRating =
              a.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ??
                  0;
          final bRating =
              b.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ??
                  0;
          return bRating.compareTo(aRating); // High to low
        });
        break;
      case 'RatingLowToHigh': // Add a case for low to high rating
        products.sort((a, b) {
          final aRating =
              a.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ??
                  0;
          final bRating =
              b.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ??
                  0;
          return aRating.compareTo(bRating); // Low to high
        });
        break;
      default:
        // Keep recommended order or default sorting
        break;
    }
    return products;
  }

  // Setter for sort criteria
  void setSortCriteria(String sortCriteria) {
    _sortCriteria = sortCriteria;
    filterProducts();
  }

  // Setter for product display limit
  void setProductDisplayLimit(int limit) {
    _productDisplayLimit = limit;
    filterProducts();
  }

  // Other existing setters for filters
  void setPriceRange(double minPrice, double maxPrice) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    filterProducts();
  }

  void setSelectedBrands(Set<String> selectedBrands) {
    _selectedBrands = selectedBrands;
    filterProducts();
  }

  void setRating(double rating) {
    _currentRating = rating;
    filterProducts();
  }

  void clearPriceFilter() {
    _minPrice = 0;
    _maxPrice = 2000;
    filterProducts();
  }

  void clearBrandFilter() {
    _selectedBrands.clear();
    filterProducts();
  }

  void clearRatingFilter() {
    _currentRating = 1.0;
    filterProducts();
  }

  void clearAllFilters() {
    clearPriceFilter();
    clearBrandFilter();
    clearRatingFilter();
  }
}
