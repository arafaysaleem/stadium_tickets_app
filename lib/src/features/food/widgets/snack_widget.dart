import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/snack_model.codegen.dart';

// Providers
import '../providers/food_provider.codegen.dart';
import '../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

// Features
import '../../events/events.dart';

class SnackWidget extends HookConsumerWidget {
  final SnackModel snack;

  const SnackWidget({required this.snack, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catSelectedSnacksProv =
        ref.watch(currentCategorySelectedSnacksProvider);
    final qty = catSelectedSnacksProv[snack] ?? 0;
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 90),
    );
    final bounceAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: animController,
        curve: Curves.easeInQuad,
      ),
    );
    useEffect(
      () {
        bounceAnimation.addStatusListener((status) {
          if (status == AnimationStatus.completed) animController.reverse();
        });
        return null;
      },
      const [],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Snack image
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceColor.withOpacity(0.2),
            borderRadius: Corners.rounded15,
          ),
          child: Stack(
            children: [
              // Image
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 21, 10, 10),
                child: CustomNetworkImage(
                  height: 90,
                  radius: 15,
                  imageUrl: snack.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: const EventPosterPlaceholder(),
                  errorWidget: const EventPosterPlaceholder(),
                ),
              ),

              // Decrease
              Positioned(
                top: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    if (qty > 1) animController.forward();
                    final categoryId =
                        ref.read(currentCategoryProvider)!.categoryId;
                    ref
                        .read(categorySnacksProvider.notifier)
                        .removeSnack(snack, categoryId);
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
              ),

              // Increase
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    animController.forward();
                    final categoryId =
                        ref.read(currentCategoryProvider)!.categoryId;
                    ref
                        .read(categorySnacksProvider.notifier)
                        .addSnack(snack, categoryId);
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
                ),
              ),

              // Quantity
              AnimatedPositioned(
                bottom: 0,
                right: qty > 0 ? 0 : -35,
                duration: const Duration(milliseconds: 90),
                child: AnimatedBuilder(
                  animation: bounceAnimation,
                  builder: (ctx, child) => Transform.scale(
                    scale: bounceAnimation.value,
                    child: child,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.fromLTRB(0, 0, 7, 3),
                    child: CustomText.label('$qty'),
                  ),
                ),
              ),
            ],
          ),
        ),

        Insets.expand,

        // Snack price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomText.subtitle(
            '\$ ${snack.price.toDouble()}',
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite80Color,
          ),
        ),

        Insets.gapH3,

        // Snack name
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            snack.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              fontFamily: AppTypography.secondaryFontFamily,
              color: AppColors.textLightGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
