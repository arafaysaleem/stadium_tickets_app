import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Models
import '../../models/snack_model.codegen.dart';

// Providers
import '../../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Features
import '../../../events/events.dart';

class CartDetailsListView extends ConsumerWidget {
  final ScrollController scrollController;

  const CartDetailsListView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryMap = ref.watch(categorySnacksProvider);
    return ListView.separated(
      itemCount: categoryMap.length,
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      separatorBuilder: (context, index) {
        final category = categoryMap.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(15),
          child: CustomText.title(
            category.name,
            color: AppColors.textWhite80Color,
            fontSize: 18,
          ),
        );
      },
      itemBuilder: (context, index) {
        final category = categoryMap.keys.elementAt(index);
        final snacks = categoryMap[category]!;
        return CartDetailsListItem(snacks: snacks);
      },
    );
  }
}

class CartDetailsListItem extends StatelessWidget {
  const CartDetailsListItem({
    super.key,
    required this.snacks,
  });

  final Map<SnackModel, int> snacks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          for (var snack in snacks.keys)
            CartDetailSnackItem(
              snack: snack,
              quantity: snacks[snack]!,
            )
        ],
      ),
    );
  }
}

class CartDetailSnackItem extends ConsumerWidget {
  const CartDetailSnackItem({
    super.key,
    required this.snack,
    required this.quantity,
  });

  final SnackModel snack;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Snack image
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surfaceColor.withOpacity(0.2),
              borderRadius: Corners.rounded15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomNetworkImage(
                height: 50,
                width: 50,
                radius: 15,
                imageUrl: snack.imageUrl,
                fit: BoxFit.contain,
                placeholder: const EventPosterPlaceholder(),
                errorWidget: const EventPosterPlaceholder(),
              ),
            ),
          ),

          // Snack name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Snack name
                Text(
                  snack.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    fontFamily: AppTypography.secondaryFontFamily,
                    color: AppColors.textLightGreyColor,
                  ),
                ),

                Insets.gapH5,

                // Snack price
                CustomText.subtitle(
                  '\$ ${snack.price.toDouble()}',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite80Color,
                ),
              ],
            ),
          ),

          // Snack Qty Decrease
          InkWell(
            onTap: () {
              ref.read(categorySnacksProvider.notifier).removeSnack(snack);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.all(7),
              child: const Icon(
                Icons.remove,
                size: 15,
              ),
            ),
          ),

          // Snack Qty
          CustomText.label('$quantity'),

          // Snack Qty Increase
          InkWell(
            onTap: () {
              ref.read(categorySnacksProvider.notifier).selectSnack(snack);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.all(7),
              child: const Icon(
                Icons.add,
                size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
