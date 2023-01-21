import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../models/category_model.codegen.dart';
import '../models/snack_model.codegen.dart';

// Repositories
import '../repositories/food_repository.codegen.dart';

part 'food_provider.codegen.g.dart';

final currentCategoryProvider = StateProvider.autoDispose<CategoryModel?>(
  (ref) {
    return ref.watch(categoriesFutureProvider).asData?.value.first;
  },
);

@Riverpod(keepAlive: true)
Future<List<CategoryModel>> categoriesFuture(CategoriesFutureRef ref) {
  return ref.watch(foodProvider).getAllCategories();
}

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
FoodProvider food(FoodRef ref) {
  final foodRepository = ref.watch(foodRepositoryProvider);
  return FoodProvider(ref, foodRepository);
}

class FoodProvider {
  final Ref ref;
  final FoodRepository _foodRepository;

  FoodProvider(this.ref, this._foodRepository);

  Future<List<CategoryModel>> getAllCategories([JSON? queryParams]) async {
    return _foodRepository.fetchAllCategories(queryParameters: queryParams);
  }

  Future<List<SnackModel>> getAllCategorySnacks(int id) async {
    return _foodRepository.fetchAllCategorySnacks(categoryId: id);
  }
}
