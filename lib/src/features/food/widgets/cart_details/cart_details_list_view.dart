import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Models
import '../../models/brand_model.codegen.dart';
import '../../models/snack_model.codegen.dart';

// Providers
import '../../providers/category_snacks_provider.codegen.dart';
import '../../providers/food_provider.codegen.dart';

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
    return ListView.builder(
      itemCount: categoryMap.length,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (context, index) {
        final categoryId = categoryMap.keys.elementAt(index);
        final category = ref
            .watch(categoriesFutureProvider)
            .asData
            ?.value
            .firstWhere((c) => c.categoryId == categoryId);
        final snacks = categoryMap[categoryId]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CustomText.body(
                category!.name,
                color: AppColors.textWhite80Color,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Category Items
            CartDetailsListItem(
              snacks: snacks,
              brands: category.brands,
            ),

            Insets.gapH10,
          ],
        );
      },
    );
  }
}

class CartDetailsListItem extends StatelessWidget {
  const CartDetailsListItem({
    super.key,
    required this.snacks,
    required this.brands,
  });

  final Map<SnackModel, int> snacks;
  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var snack in snacks.keys)
          CartDetailSnackItem(
            snack: snack,
            brand: brands
                .firstWhere((element) => element.brandId == snack.brandId),
            quantity: snacks[snack]!,
          )
      ],
    );
  }
}

class CartDetailSnackItem extends ConsumerWidget {
  const CartDetailSnackItem({
    super.key,
    required this.snack,
    required this.brand,
    required this.quantity,
  });

  final SnackModel snack;
  final int quantity;
  final BrandModel brand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: Corners.rounded15,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Snack image
              CustomNetworkImage(
                height: 50,
                width: 50,
                radius: 0,
                imageUrl: snack.imageUrl,
                fit: BoxFit.contain,
                placeholder: const EventPosterPlaceholder(),
                errorWidget: const EventPosterPlaceholder(),
              ),

              Insets.gapW10,

              // Snack name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Snack name
                    Text(
                      snack.name,
                      style: TextStyle(
                        fontSize: 14,
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

              // Brand Details Column
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand name
                  Text(
                    brand.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: AppTypography.secondaryFontFamily,
                      color: AppColors.textWhite80Color,
                    ),
                  ),

                  // Brand image
                  CustomNetworkImage(
                    height: 25,
                    width: 50,
                    radius: 0,
                    imageUrl: brand.logoUrl,
                    fit: BoxFit.contain,
                    placeholder: const EventPosterPlaceholder(),
                    errorWidget: const EventPosterPlaceholder(),
                  ),
                ],
              ),

              // Snack Qty Decrease
              InkWell(
                onTap: () {
                  if (quantity > 1) {
                    ref
                        .read(categorySnacksProvider.notifier)
                        .removeSnack(snack, brand.categoryId);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(9),
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ),

              // Snack Qty
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: CustomText.subtitle('$quantity'),
              ),

              // Snack Qty Increase
              InkWell(
                onTap: () {
                  ref
                      .read(categorySnacksProvider.notifier)
                      .addSnack(snack, brand.categoryId);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(9),
                  child: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
              ),

              Insets.gapW5,

              // Delete icon
              InkWell(
                onTap: () {
                  ref
                      .read(categorySnacksProvider.notifier)
                      .deleteSnackFromCategory(snack, brand.categoryId);
                },
                child: const Icon(
                  Icons.delete,
                  color: AppColors.textLightGreyColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
