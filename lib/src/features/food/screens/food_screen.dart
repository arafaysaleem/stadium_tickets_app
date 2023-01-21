import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Router
import '../../../config/routing/routing.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/categories_list.dart';
import '../widgets/category_snacks_grid_loader.dart';
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
                        ..invalidate(categorySnacksFutureProvider)
                        ..invalidate(categorySnacksProvider);
                    },
                  ),

                  // Parking Floor
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

            // Floors List
            const CategoriesList(),

            Insets.gapH25,

            // Spots
            const Expanded(
              child: CategorySnacksGridLoader(),
            ),

            // Purchase & Cart Button
            Row(
              children: const [
                // Select
                SelectSnacksButton(),

                // Cart Button
                CartButton(),
              ],
            ),

            Insets.gapH20,
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) {
            return Insets.shrink;
            // return const FiltersBottomSheet();
          },
        );
      },
      child: Container(
        height: 47,
        width: 47,
        decoration: const BoxDecoration(
          gradient: AppColors.buttonGradientPrimary,
          borderRadius: Corners.rounded7,
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: AppColors.textWhite80Color,
        ),
      ),
    );
  }
}
