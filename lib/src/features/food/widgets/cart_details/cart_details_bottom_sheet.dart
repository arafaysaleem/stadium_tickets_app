import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/category_snacks_provider.codegen.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';
import 'cart_details_list_view.dart';

class CartDetailsBottomSheet extends ConsumerWidget {
  const CartDetailsBottomSheet({super.key});

  void _onResetTap(WidgetRef ref) {
    ref.read(categorySnacksProvider.notifier).empty();
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: CustomScrollableBottomSheet(
        titleText: 'Cart',
        leading: Consumer(
          builder: (_, ref, child) {
            final cartEmpty = ref.watch(
              categorySnacksProvider.select((value) => value.isEmpty),
            );
            return cartEmpty ? const SizedBox(width: 50, height: 30) : child!;
          },
          child: GestureDetector(
            onTap: () => _onResetTap(ref),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: CustomText(
                'Empty',
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        builder: (_, scrollController) => CartDetailsListView(
          scrollController: scrollController,
        ),
      ),
    );
  }
}
