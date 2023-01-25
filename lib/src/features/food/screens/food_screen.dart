import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Router
import '../../../config/routing/routing.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/brands_list.dart';
import '../widgets/cart_button.dart';
import '../widgets/categories_list.dart';
import '../widgets/brand_snacks_grid_loader.dart';
import '../widgets/select_snacks_button.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH10,

            // Icon and title row
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Row(
                children: [
                  CustomBackIcon(
                    onTap: () {
                      AppRouter.pop();
                      ref
                        ..invalidate(brandSnacksFutureProvider)
                        ..invalidate(categorySnacksProvider);
                    },
                  ),

                  // Food title
                  const Expanded(
                    child: CustomText(
                      'Pick Food Items',
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 30),
                ],
              ),
            ),

            Insets.gapH20,

            // Categories List
            const CategoriesList(),

            Insets.gapH25,

            // Brands List
            const BrandsList(),

            Insets.gapH25,

            // Snacks
            const Expanded(
              child: BrandSnacksGridLoader(),
            ),

            // Purchase & Cart Button
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Row(
                children: [
                  // Select
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: SelectSnacksButton(),
                    ),
                  ),

                  Insets.gapW15,

                  // Cart Button
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 5),
                        child: CartButton(),
                      ),

                      // Snacks count
                      Consumer(
                        builder: (context, ref, child) {
                          final snacks = ref.watch(
                            categorySnacksProvider.select(
                              (catMap) => catMap.values.fold(
                                0,
                                (prev, snackMap) => prev + snackMap.values.sum,
                              ),
                            ),
                          );

                          return snacks <= 0
                              ? Insets.shrink
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.textWhite80Color,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 19,
                                      minHeight: 19,
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        '$snacks',
                                        fontSize: 11,
                                        color: AppColors.textBlackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Insets.gapH20,
          ],
        ),
      ),
    );
  }
}
