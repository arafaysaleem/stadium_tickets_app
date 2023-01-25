import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
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

  Future<List<SnackModel>> fetchAllBrandSnacks({
    required int brandId,
    required int categoryId,
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<SnackModel>(
      endpoint: FoodEndpoint.CATEGORY_BRAND_SNACKS.route(
        brandId: brandId,
        categoryId: categoryId,
      ),
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

  static const _brands = <int, List<JSON>>{
    1: [
      <String, dynamic>{
        'brand_id': 1,
        'name': 'Coca-Cola',
        'logo_url':
            'https://seeklogo.com/images/C/coca-cola-circle-logo-A9EBD3B00A-seeklogo.com.png',
        'category_id': 1,
      },
    ],
    2: [
      <String, dynamic>{
        'brand_id': 2,
        'name': 'Lays',
        'logo_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lays_brand_logo.png/300px-Lays_brand_logo.png',
        'category_id': 2,
      },
    ],
    3: [
      <String, dynamic>{
        'brand_id': 3,
        'name': 'Pizza Hut',
        'logo_url':
            'https://www.freepnglogos.com/uploads/pizza-hut-png-logo/does-the-new-logo-flavors-pizza-hut-png-13.png',
        'category_id': 3,
      },
    ],
    4: [
      <String, dynamic>{
        'brand_id': 4,
        'name': 'Burger King',
        'logo_url':
            'https://assets.stickpng.com/images/5842996fa6515b1e0ad75add.png',
        'category_id': 4,
      },
    ],
    5: [
      <String, dynamic>{
        'brand_id': 5,
        'name': 'KFC',
        'logo_url':
            'https://www.freepnglogos.com/uploads/kfc-png-logo/camera-kfc-png-logo-0.png',
        'category_id': 5,
      },
    ],
  };

  static const _snacks = <int, List<SnackModel>>{
    1: [
      SnackModel(
        snackId: 1,
        brandId: 1,
        name: 'Coke',
        price: 10,
        imageUrl:
            'https://www.seekpng.com/png/detail/56-561367_banner-royalty-free-library-png-transparent-images-can.png',
      ),
      SnackModel(
        snackId: 2,
        brandId: 1,
        name: 'Mineral Water',
        price: 5,
        imageUrl:
            'https://banner2.cleanpng.com/20171220/bqw/water-bottle-png-image-5a3ab38d99d457.62425636151379649363014217.jpg',
      ),
    ],
    2: [
      SnackModel(
        snackId: 3,
        brandId: 2,
        name: 'Classic',
        price: 4,
        imageUrl:
            'https://www.pngfind.com/pngs/m/22-222552_lays-potato-chips-png-transparent-image-lays-png.png',
      ),
      SnackModel(
        snackId: 4,
        brandId: 2,
        name: 'French Cheese',
        price: 4,
        imageUrl:
            'https://www.nicepng.com/png/detail/942-9429970_lays-chips-french-cheese-70-gm-lays.png',
      ),
      SnackModel(
        snackId: 5,
        brandId: 2,
        name: 'Wavy',
        price: 5,
        imageUrl:
            'https://e7.pngegg.com/pngimages/595/1022/png-clipart-lay-s-wavy-chip-plastic-pack-french-fries-lays-wow-chips-chocolate-covered-potato-chips-lays-classic-potato-chips-packet-food-dipping-sauce-thumbnail.png',
      ),
    ],
    3: [
      SnackModel(
        snackId: 6,
        brandId: 3,
        name: 'Cheese Burst',
        price: 20,
        imageUrl:
            'https://www.pngkey.com/png/full/123-1230165_singapore-pizza-hut-menu-pizza-hut-seafood-deluxe.png',
      ),
      SnackModel(
        snackId: 7,
        brandId: 3,
        name: 'Veggie',
        price: 20,
        imageUrl:
            'https://www.nicepng.com/png/full/52-522964_singapore-pizza-hut-menu-food.png',
      ),
      SnackModel(
        snackId: 8,
        brandId: 3,
        name: 'Peppy Paneer',
        price: 20,
        imageUrl:
            'https://www.nicepng.com/png/detail/811-8114767_welcome-to-pizza-hut-middle-east-pizza-hut.png',
      ),
    ],
    4: [
      SnackModel(
        snackId: 9,
        brandId: 4,
        name: 'Whopper',
        price: 16,
        imageUrl:
            'https://www.nicepng.com/png/detail/379-3799619_69kib-500x540-muttonwhopper-detail-0-burger-king-burger.png',
      ),
      SnackModel(
        snackId: 10,
        brandId: 4,
        name: 'Chicken Royale',
        price: 16,
        imageUrl:
            'https://www.pngitem.com/pimgs/m/523-5236317_double-whopper-burger-king-hd-png-download.png',
      ),
    ],
    5: [
      SnackModel(
        snackId: 12,
        brandId: 5,
        name: 'Family Bucket',
        price: 40,
        imageUrl:
            'https://toppng.com/uploads/preview/kfc-bucket-kfc-bucket-chicken-philippines-115632629900ljez85rhg.png',
      ),
      SnackModel(
        snackId: 13,
        brandId: 5,
        name: 'Zinger Stacker',
        price: 16,
        imageUrl:
            'https://www.nicepng.com/png/detail/79-793298_kfc-burger-transparent-big-cheese-burger-kfc.png',
      ),
      SnackModel(
        snackId: 15,
        brandId: 5,
        name: 'Chicken Wings',
        price: 15,
        imageUrl:
            'https://www.pngkey.com/png/full/36-362333_kfc-chicken-wings-bucket-broasted-chicken.png',
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
          'brands': _brands[1],
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 2,
          'name': 'Chips',
          'brands': _brands[2],
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 3,
          'name': 'Pizza',
          'brands': _brands[3],
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 4,
          'name': 'Burgers',
          'brands': _brands[4],
        }),
        CategoryModel.fromJson(<String, dynamic>{
          'category_id': 5,
          'name': 'Chicken',
          'brands': _brands[5],
        }),
      ],
    );
  }

  @override
  Future<List<SnackModel>> fetchAllBrandSnacks({
    required int brandId,
    required int categoryId,
    JSON? queryParameters,
  }) {
    return Future.delayed(
      2.seconds,
      () => _snacks[brandId] ?? [],
    );
  }
}
