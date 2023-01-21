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
List<SnackModel> currentCategorySelectedSnacks(CurrentCategorySelectedSnacksRef ref) {
  final snacksMap = ref.watch(categorySnacksProvider);
  final activeCategoryId = ref.watch(currentCategoryProvider)!.categoryId;
  return snacksMap[activeCategoryId] ?? [];
}

final confirmedCategorySnacksProvider =
    StateProvider.autoDispose<Map<int, List<SnackModel>>>(
  (ref) {
    return {};
  },
);

@riverpod
class CategorySnacks extends _$CategorySnacks {
  @override
  Map<int, List<SnackModel>> build() {
    final categorySnacks = ref
        .watch(confirmedCategorySnacksProvider)
        .map((key, value) => MapEntry(key, [...value]));
    return {...categorySnacks};
  }

  void selectSnack(SnackModel snack) {
    final category = ref.read(currentCategoryProvider)!;
    state.update(
      category.categoryId,
      (value) => [...value, snack],
      ifAbsent: () => [snack],
    );
    state = {...state};
  }

  void removeSnack(SnackModel snack) {
    final categoryId = ref.read(currentCategoryProvider)!.categoryId;
    state.update(
      categoryId,
      (value) {
        value.remove(snack);
        return [...value];
      },
      ifAbsent: () => [snack],
    );
    state = {...state};
  }
}
