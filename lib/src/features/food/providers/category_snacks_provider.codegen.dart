import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
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
Map<int, int> currentCategorySelectedSnacks(
  CurrentCategorySelectedSnacksRef ref,
) {
  final snacksMap = ref.watch(categorySnacksProvider);
  final activeCategoryId = ref.watch(currentCategoryProvider)!.categoryId;
  return snacksMap[activeCategoryId] ?? {};
}

final confirmedCategorySnacksProvider =
    StateProvider.autoDispose<Map<int, Map<int, int>>>(
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
  Map<int, Map<int, int>> build() {
    final categorySnacks = ref
        .watch(confirmedCategorySnacksProvider)
        .map((key, value) => MapEntry(key, {...value}));
    return {...categorySnacks};
  }

  /// Increases the quantity of the snack having snackId by 1
  /// If the snack is not in the map, it is added with quantity 1
  void selectSnack(int snackId) {
    final category = ref.read(currentCategoryProvider)!;
    state.update(
      category.categoryId,
      (value) {
        value.update(
          snackId,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
        return {...value};
      },
      ifAbsent: () => {snackId: 1},
    );
    state = {...state};
  }

  /// Decreases the quantity of the snack having snackId by 1
  /// If the quantity is 1, the snack is removed from the map
  /// If the snack is not in the map, nothing happens
  /// If the snack's category is not in the map, nothing happens
  void removeSnack(int snackId) {
    final categoryId = ref.read(currentCategoryProvider)!.categoryId;
    if (!state.containsKey(categoryId) ||
        !state[categoryId]!.containsKey(snackId)) return;

    state.update(
      categoryId,
      (value) {
        final qty = value[snackId]!;

        if (qty > 1) {
          value.update(
            snackId,
            (value) => value - 1,
          );
        } else {
          value.remove(snackId);
        }
        return {...value};
      },
    );
    if (state[categoryId]!.isEmpty) state.remove(categoryId);
    state = {...state};
  }
}
