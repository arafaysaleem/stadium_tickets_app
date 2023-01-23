import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/category_model.codegen.dart';
import '../models/snack_model.codegen.dart';

// Providers
import 'food_provider.codegen.dart';

part 'category_snacks_provider.codegen.g.dart';

@Riverpod(keepAlive: true)
Future<List<SnackModel>?> categorySnacksFuture(
  CategorySnacksFutureRef ref,
  int? categoryId,
) {
  if (categoryId == null) return Future.value();
  return ref.watch(foodProvider).getAllCategorySnacks(categoryId);
}

@riverpod
Map<SnackModel, int> currentCategorySelectedSnacks(
  CurrentCategorySelectedSnacksRef ref,
) {
  final snacksMap = ref.watch(categorySnacksProvider);
  final activeCategory = ref.watch(currentCategoryProvider)!;
  return snacksMap[activeCategory] ?? {};
}

final confirmedCategorySnacksProvider =
    StateProvider.autoDispose<Map<CategoryModel, Map<SnackModel, int>>>(
  (ref) {
    return {};
  },
);

@riverpod
class CategorySnacks extends _$CategorySnacks {
  /// Stores the selected snacks for each category
  /// The outer map is the category id
  /// The inner map is the snack id and the quantity
  @override
  Map<CategoryModel, Map<SnackModel, int>> build() {
    final categorySnacks = ref
        .watch(confirmedCategorySnacksProvider)
        .map((key, value) => MapEntry(key, {...value}));
    return {...categorySnacks};
  }

  /// Increases the quantity of the snack having snackId by 1
  /// If the snack is not in the map, it is added with quantity 1
  void selectSnack(SnackModel snack) {
    final category = ref.read(currentCategoryProvider)!;
    state.update(
      category,
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
  void removeSnack(SnackModel snack) {
    final category = ref.read(currentCategoryProvider)!;
    if (!state.containsKey(category) ||
        !state[category]!.containsKey(snack)) return;

    state.update(
      category,
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
    if (state[category]!.isEmpty) state.remove(category);
    state = {...state};
  }

  void empty() {
    state = {};
  }
}
