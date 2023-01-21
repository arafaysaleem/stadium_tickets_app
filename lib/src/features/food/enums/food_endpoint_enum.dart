// ignore_for_file: constant_identifier_names

enum FoodEndpoint {
  BASE,
  CATEGORIES,
  CATEGORY_SNACKS;

  const FoodEndpoint();

  static const _baseRoute = '/food';
  static const _categoriesRoute = 'categories';
  static const _snacksRoute = 'snacks';

  /// Returns the path for food [endpoint].
  ///
  /// Specify food [categoryId] to get the path for a specific category.
  String route({int? id, int? categoryId}) {
    switch (this) {
      case FoodEndpoint.BASE:
        return _baseRoute;
      case FoodEndpoint.CATEGORIES:
        {
          return '$_baseRoute/$_categoriesRoute';
        }
      case FoodEndpoint.CATEGORY_SNACKS:
        {
          assert(
            categoryId != null,
            'categoryId is required for the CATEGORY_ITEMS endpoint',
          );
          return '$_baseRoute/$_categoriesRoute/$categoryId/$_snacksRoute';
        }
    }
  }
}
