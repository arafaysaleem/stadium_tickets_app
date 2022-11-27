import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/extensions/string_extension.dart';

// Router
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Providers
import '../providers/zones_provider.dart';

// Widgets
import '../../../global/widgets/custom_back_icon.dart';
import '../../../global/widgets/custom_text.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/labeled_widget.dart';

class ZoneDetails extends ConsumerWidget {
  final bool isLeft;

  const ZoneDetails({
    required this.isLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zone = ref.watch(currentZoneProvider);
    if (zone == null) return Insets.shrink;
    final padLeft = isLeft ? 10.0 : 20.0;
    final padRight = isLeft ? 20.0 : 10.0;
    return Row(
      mainAxisAlignment:
          isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 155,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back
              Row(
                mainAxisAlignment:
                    isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  RotatedBox(
                    quarterTurns: isLeft ? 2 : 0,
                    child: CustomBackIcon(
                      onTap: () {
                        ref.read(currentZoneNoProvider.notifier).state = null;
                      },
                    ),
                  ),
                ],
              ),

              Insets.gapH(12),

              // Zone Name
              SizedBox(
                height: 76,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      zone.name,
                      fontSize: 30,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),

              Insets.gapH(40),

              // Row 1
              Padding(
                padding: EdgeInsets.fromLTRB(padLeft, 0, padRight, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Zone Type
                    LabeledWidget(
                      label: 'Type',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLightGreyColor,
                      ),
                      child: CustomText.body(
                        zone.type.type.capitalize,
                        fontSize: 15,
                      ),
                    ),

                    // Price
                    LabeledWidget(
                      label: 'Price',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLightGreyColor,
                      ),
                      child: CustomText.body(
                        '\$${zone.type.price}',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              Insets.gapH20,

              // Row 2
              Padding(
                padding: EdgeInsets.fromLTRB(padLeft, 0, padRight, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Zone Type
                    LabeledWidget(
                      label: 'Rows',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLightGreyColor,
                      ),
                      child: CustomText.body(
                        '${zone.numOfRows}',
                        fontSize: 15,
                      ),
                    ),

                    // Price
                    LabeledWidget(
                      label: 'Seats/row',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLightGreyColor,
                      ),
                      child: CustomText.body(
                        '${zone.seatsPerRow}',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              Insets.expand,

              Padding(
                padding: EdgeInsets.fromLTRB(padLeft - 5, 0, padRight - 5, 0),
                child: CustomTextButton.outlined(
                  onPressed: () {},
                  width: double.infinity,
                  height: 44,
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                  child: CustomText.body(
                    'Check View',
                    fontSize: 15,
                    color: AppColors.textWhite80Color,
                  ),
                ),
              ),

              Insets.gapH15,

              Padding(
                padding: EdgeInsets.fromLTRB(padLeft - 5, 0, padRight - 5, 0),
                child: CustomTextButton.gradient(
                  onPressed: () {
                    AppRouter.pushNamed(Routes.ZoneSeatsScreenRoute);
                  },
                  width: double.infinity,
                  height: 44,
                  gradient: AppColors.buttonGradientPrimary,
                  child: CustomText.body(
                    'Check Seats',
                    fontSize: 15,
                    color: AppColors.textWhite80Color,
                  ),
                ),
              ),

              Insets.gapH10,
            ],
          ),
        ),
      ],
    );
  }
}
