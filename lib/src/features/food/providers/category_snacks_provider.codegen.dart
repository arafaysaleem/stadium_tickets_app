import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/snack_model.codegen.dart';

// Providers
import 'food_provider.codegen.dart';

part 'category_snacks_provider.codegen.g.dart';

@Riverpod(keepAlive: true)
Future<List<SnackModel>?> brandSnacksFuture(
  BrandSnacksFutureRef ref, {
  required int? brandId,
  required int? categoryId,
}) {
  if (brandId == null || categoryId == null) return Future.value();
  return ref.watch(foodProvider).getAllBrandSnacks(
    brandId: brandId,
    categoryId: categoryId,
  );
}

@riverpod
Map<SnackModel, int> currentCategorySelectedSnacks(
  CurrentCategorySelectedSnacksRef ref,
) {
  final snacksMap = ref.watch(categorySnacksProvider);
  final activeCategory = ref.watch(currentCategoryProvider)!;
  return snacksMap[activeCategory.categoryId] ?? {};
}

final confirmedCategorySnacksProvider =
    StateProvider.autoDispose<Map<int, Map<SnackModel, int>>>(
  (ref) {
    return {};
  },
);

@riverpod
class CategorySnacks extends _$CategorySnacks {
  /// Stores the selected snacks for each category
  /// The outer map is the category id
  /// The inner map is the snack and the quantity
  @override
  Map<int, Map<SnackModel, int>> build() {
    final categorySnacks = ref
        .watch(confirmedCategorySnacksProvider)
        .map((key, value) => MapEntry(key, {...value}));
    return {...categorySnacks};
  }

  /// Increases the quantity of the snack having snackId by 1
  /// If the snack is not in the map, it is added with quantity 1
  void addSnack(SnackModel snack, int categoryId) {
    state.update(
      categoryId,
      (value) {
        value.update(
          snack,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
        return {...value};
      },
      ifAbsent: () => {snack: 1},
    );
    state = {...state};
  }

  /// Decreases the quantity of the snack having snackId by 1
  /// If the quantity is 1, the snack is removed from the map
  /// If the snack is not in the map, nothing happens
  /// If the snack's category is not in the map, nothing happens
  void removeSnack(SnackModel snack, int categoryId) {
    if (!state.containsKey(categoryId) ||
        !state[categoryId]!.containsKey(snack)) return;

    state.update(
      categoryId,
      (value) {
        final qty = value[snack]!;

        if (qty > 1) {
          value.update(
            snack,
            (value) => value - 1,
          );
        } else {
          value.remove(snack);
        }
        return {...value};
      },
    );
    if (state[categoryId]!.isEmpty) state.remove(categoryId);
    state = {...state};
  }

  /// Delete snack from category
  void deleteSnackFromCategory(SnackModel snack, int categoryId) {
    if (!state.containsKey(categoryId) ||
        !state[categoryId]!.containsKey(snack)) return;
    state[categoryId]!.remove(snack);
    if (state[categoryId]!.isEmpty) state.remove(categoryId);
    state = {...state};
  }

  void empty() {
    state = {};
  }
}
