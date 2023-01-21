import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/snack_model.codegen.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';
import '../providers/food_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'category_snacks_grid.dart';

class CategorySnacksGridLoader extends ConsumerWidget {
  const CategorySnacksGridLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(currentCategoryProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      switchOutCurve: Curves.easeInBack,
      child: AsyncValueWidget<List<SnackModel>?>(
        value: ref.watch(categorySnacksFutureProvider(category?.categoryId)),
        loading: () => const CustomCircularLoader(),
        onNull: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () =>
              ref.refresh(categorySnacksFutureProvider(category?.categoryId)),
          stackTrace: st,
        ),
        data: (categorySnacks) {
          final extendBottom = categorySnacks!.length > 7;
          return Column(
            children: [
              // Snacks Area
              CategorySnacksGrid(
                extendBottom: extendBottom,
                snacks: categorySnacks,
              ),

              if (!extendBottom) Insets.expand,

              // Selected Snacks Chips
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 0, 22),
                child: Consumer(
                  builder: (ctx, ref, child) {
                    final snackNames = ref.watch(
                      currentCategorySelectedSnacksProvider.select(
                        (value) => value.map((e) => e.name).toList(),
                      ),
                    );
                    return CustomChipsList(
                      chipContents: snackNames,
                      chipHeight: 27,
                      chipGap: 10,
                      fontSize: 14,
                      chipWidth: 60,
                      borderColor: AppColors.primaryColor,
                      contentColor: AppColors.primaryColor,
                      borderWidth: 1.5,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.3),
                      isScrollable: true,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
