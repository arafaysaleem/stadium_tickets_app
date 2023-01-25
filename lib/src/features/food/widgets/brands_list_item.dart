import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
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
        width: 67,
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.buttonGradientPrimary : null,
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.primaryColor,
                ),
          borderRadius: Corners.rounded10,
        ),
        child: Center(
          child: CustomText.subtitle(brand.name),
        ),
      ),
    );
  }
}
