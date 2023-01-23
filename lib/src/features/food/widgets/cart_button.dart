import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'cart_details/cart_details_bottom_sheet.dart';

class CartButton extends ConsumerWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noSnacks = ref.watch(
      categorySnacksProvider.select(
        (catMap) => catMap.isEmpty,
      ),
    );
    final noConfirmedSnacks = ref.watch(
      confirmedCategorySnacksProvider.select(
        (catMap) => catMap.isEmpty,
      ),
    );
    return CustomTextButton.gradient(
      width: 52,
      onPressed: () {
        showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) {
            return const CartDetailsBottomSheet();
          },
        );
      },
      disabled: noSnacks && noConfirmedSnacks,
      gradient: AppColors.buttonGradientPrimary,
      child: const Center(
        child: Icon(
          Icons.shopping_cart_outlined,
          color: AppColors.textWhite80Color,
          size: 22,
        ),
      ),
    );
  }
}
