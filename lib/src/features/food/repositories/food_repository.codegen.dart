import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../models/brand_model.codegen.dart';
import '../models/category_model.codegen.dart';
import '../models/snack_model.codegen.dart';

// Enums
import '../enums/food_endpoint_enum.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'food_repository.codegen.g.dart';

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
FoodRepository foodRepository(FoodRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return MockFoodRepository(apiService: _apiService);
  // return FoodRepository(apiService: _apiService);
}

class FoodRepository {
  final ApiService _apiService;

  FoodRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<CategoryModel>> fetchAllCategories({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<CategoryModel>(
      endpoint: FoodEndpoint.CATEGORIES.route(),
      queryParams: queryParameters,
      converter: CategoryModel.fromJson,
    );
  }

  Future<List<SnackModel>> fetchAllCategorySnacks({
    required int categoryId,
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<SnackModel>(
      endpoint: FoodEndpoint.CATEGORY_SNACKS.route(categoryId: categoryId),
      queryParams: queryParameters,
      converter: SnackModel.fromJson,
    );
  }
}

class MockFoodRepository implements FoodRepository {
  @override
  final ApiService _apiService;

  MockFoodRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  static const _brands = [
    BrandModel(
      brandId: 1,
      name: 'Coca-Cola',
      logoUrl: 'https://i.imgur.com/1ZQZQ9r.png',
    ),
    BrandModel(
      brandId: 2,
      name: 'Lays',
      logoUrl: 'https://i.imgur.com/1ZQZQ9r.png',
    ),
    BrandModel(
      brandId: 3,
      name: 'Pizza Hut',
      logoUrl: 'https://i.imgur.com/1ZQZQ9r.png',
    ),
    BrandModel(
      brandId: 4,
      name: 'Burger King',
      logoUrl: 'https://i.imgur.com/1ZQZQ9r.png',
    ),
    BrandModel(
      brandId: 5,
      name: 'KFC',
      logoUrl: 'https://i.imgur.com/1ZQZQ9r.png',
    ),
  ];

  static const _snacks = <int, List<SnackModel>>{
    1: [
      SnackModel(
        snackId: 1,
        categoryId: 1,
        name: 'Coke',
        price: 10,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 2,
        categoryId: 1,
        name: 'Mineral Water',
        price: 5,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
    ],
    2: [
      SnackModel(
        snackId: 3,
        categoryId: 2,
        name: 'Masala',
        price: 4,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 4,
        categoryId: 2,
        name: 'French Cheese',
        price: 4,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 5,
        categoryId: 2,
        name: 'Wavy',
        price: 5,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
    ],
    3: [
      SnackModel(
        snackId: 6,
        categoryId: 3,
        name: 'Cheese Burst',
        price: 20,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 7,
        categoryId: 3,
        name: 'Veggie',
        price: 20,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 8,
        categoryId: 3,
        name: 'Peppy Paneer',
        price: 20,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
    ],
    4: [
      SnackModel(
        snackId: 9,
        categoryId: 4,
        name: 'Whopper',
        price: 16,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 10,
        categoryId: 4,
        name: 'Chicken Royale',
        price: 16,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 11,
        categoryId: 4,
        name: 'Chicken Whopper',
        price: 16,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
    ],
    5: [
      SnackModel(
        snackId: 12,
        categoryId: 5,
        name: 'Family Bucket',
        price: 40,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 13,
        categoryId: 5,
        name: 'Zinger Stacker',
        price: 16,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 14,
        categoryId: 5,
        name: 'Zinger Box',
        price: 20,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      ),
      SnackModel(
        snackId: 15,
        categoryId: 5,
        name: 'Chicken Wings',
        price: 15,
        imageUrl: 'https://i.imgur.com/1ZQZQ9r.png',
      )
    ],
  };

  @override
  Future<List<CategoryModel>> fetchAllCategories({JSON? queryParameters}) {
    return Future.delayed(
      2.seconds,
      () => <CategoryModel>[
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 1,
          'name': 'Drinks',
          'seller_brand': _brands[0].toJson(),
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 2,
          'name': 'Chips',
          'seller_brand': _brands[1].toJson(),
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 3,
          'name': 'Pizza',
          'seller_brand': _brands[2].toJson(),
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 4,
          'name': 'Burgers',
          'seller_brand': _brands[3].toJson(),
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 5,
          'name': 'Chicken',
          'seller_brand': _brands[4].toJson(),
        }),
      ],
    );
  }

  @override
  Future<List<SnackModel>> fetchAllCategorySnacks({
    required int categoryId,
    JSON? queryParameters,
  }) {
    return Future.delayed(
      2.seconds,
      () => _snacks[categoryId] ?? [],
    );
  }
}
