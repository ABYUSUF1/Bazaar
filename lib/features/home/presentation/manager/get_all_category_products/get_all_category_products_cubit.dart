import 'package:bazaar/core/utils/entities/products_details_entity.dart';
import 'package:bazaar/features/home/domain/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    // Use a single pass for filtering
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
      productDisplayLimit: _productDisplayLimit,
    ));
  }

  List<ProductsDetailsEntity> _sortProducts(
      List<ProductsDetailsEntity> products) {
    switch (_sortCriteria) {
      case 'PriceHighToLow':
        products.sort((a, b) => _compareByTotalPrice(b, a));
        break;
      case 'PriceLowToHigh':
        products.sort((a, b) => _compareByTotalPrice(a, b));
        break;
      case 'Rating':
        products.sort((a, b) => _compareByTotalRating(b, a));
        break;
      case 'RatingLowToHigh':
        products.sort((a, b) => _compareByTotalRating(a, b));
        break;
      default:
        // Keep recommended order or default sorting
        break;
    }
    return products;
  }

  int _compareByTotalPrice(ProductsDetailsEntity a, ProductsDetailsEntity b) {
    final aPrice =
        a.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
    final bPrice =
        b.products?.map((e) => e.price ?? 0).reduce((a, b) => a + b) ?? 0;
    return aPrice.compareTo(bPrice);
  }

  int _compareByTotalRating(ProductsDetailsEntity a, ProductsDetailsEntity b) {
    final aRating =
        a.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ?? 0;
    final bRating =
        b.products?.map((e) => e.rating ?? 0).reduce((a, b) => a + b) ?? 0;
    return aRating.compareTo(bRating);
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
