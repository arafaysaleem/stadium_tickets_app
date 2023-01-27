import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../../events/events.dart';
import '../models/brand_model.codegen.dart';

// Providers
import '../providers/food_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class BrandsListItem extends ConsumerWidget {
  final BrandModel brand;

  const BrandsListItem({
    super.key,
    required this.brand,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentCategoryBrandProvider.select((value) => value == brand),
    );
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          ref.read(currentCategoryBrandProvider.notifier).state = brand;
        }
      },
      child: AnimatedContainer(
        duration: Durations.medium,
        curve: Curves.fastOutSlowIn,
        width: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
          color: AppColors.surfaceColor,
          borderRadius: Corners.rounded15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand logo
            CustomNetworkImage(
              height: 55,
              radius: 15,
              imageUrl: brand.logoUrl,
              fit: BoxFit.contain,
              placeholder: const EventPosterPlaceholder(iconSize: 25),
              errorWidget: const EventPosterPlaceholder(iconSize: 25),
            ),

            // Brand name
            CustomText(
              brand.name,
              maxLines: 1,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
