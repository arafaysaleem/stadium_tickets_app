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
import 'brand_snacks_grid.dart';

class BrandSnacksGridLoader extends ConsumerWidget {
  const BrandSnacksGridLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(currentCategoryBrandProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      switchOutCurve: Curves.easeInBack,
      child: AsyncValueWidget<List<SnackModel>?>(
        value: ref.watch(
          brandSnacksFutureProvider(
            brandId: brand?.brandId,
            categoryId: brand?.categoryId,
          ),
        ),
        loading: () => const CustomCircularLoader(),
        onNull: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          stackTrace: st,
          retryCallback: () => ref.refresh(
            brandSnacksFutureProvider(
              brandId: brand?.brandId,
              categoryId: brand?.categoryId,
            ),
          ),
        ),
        data: (brandSnacks) {
          final extendBottom = brandSnacks!.length > 4;
          return Column(
            children: [
              // Snacks Area
              BrandSnacksGrid(
                extendBottom: extendBottom,
                snacks: brandSnacks,
              ),

              if (!extendBottom) Insets.expand,
            ],
          );
        },
      ),
    );
  }
}
