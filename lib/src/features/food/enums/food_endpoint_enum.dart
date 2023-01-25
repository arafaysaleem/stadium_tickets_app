// ignore_for_file: constant_identifier_names

enum FoodEndpoint {
  BASE,
  CATEGORIES,
  CATEGORY_BRAND_SNACKS;

  const FoodEndpoint();

  static const _baseRoute = '/food';
  static const _categoriesRoute = 'categories';
  static const _brandsRoute = 'brands';
  static const _snacksRoute = 'snacks';

  /// Returns the path for food [endpoint].
  ///
  /// Specify food [brandId] and [categoryId] to get the path for a specific brand.
  String route({int? id, int? brandId, int? categoryId}) {
    switch (this) {
      case FoodEndpoint.BASE:
        return _baseRoute;
      case FoodEndpoint.CATEGORIES:
        {
          return '$_baseRoute/$_categoriesRoute';
        }
      case FoodEndpoint.CATEGORY_BRAND_SNACKS:
        {
          assert(
            brandId != null && categoryId != null,
            'brandId and categoryId are required for the CATEGORY_BRAND_SNACKS endpoint',
          );
          return '$_baseRoute/$_categoriesRoute/$categoryId/$_brandsRoute/$brandId/$_snacksRoute';
        }
    }
  }
}
