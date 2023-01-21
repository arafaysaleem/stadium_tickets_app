import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/category_model.codegen.dart';

// Providers
import '../providers/food_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class CategoriesListItem extends ConsumerWidget {
  final CategoryModel category;

  const CategoriesListItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentCategoryProvider.select((value) => value == category),
    );
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          ref.read(currentCategoryProvider.notifier).state = category;
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
          child: CustomText.subtitle(category.name),
        ),
      ),
    );
  }
}
