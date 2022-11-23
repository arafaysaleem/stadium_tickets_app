import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../global/widgets/custom_back_icon.dart';
import '../../../global/widgets/custom_text.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_utils.dart';

// Providers
import '../providers/zones_provider.dart';

class ZoneInfoCard extends StatelessWidget {
  const ZoneInfoCard({
    super.key,
    required this.isSelected,
    required this.slideRight,
    required this.top,
  });

  final bool isSelected;
  final bool slideRight;
  final double top;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Durations.medium,
      top: top,
      right: !isSelected
          ? 0
          : !slideRight
              ? -15
              : 15,
      left: !isSelected
          ? 0
          : slideRight
              ? -15
              : 15,
      child: AnimatedOpacity(
        opacity: isSelected ? 1 : 0,
        duration: Durations.fast,
        curve: Curves.easeInCirc,
        child: Container(
          height: 450,
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 45,
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: Corners.rounded(35),
            color: const Color.fromARGB(255, 57, 57, 57),
          ),
          child: ZoneDetails(
            isLeft: slideRight,
          ),
        ),
      ),
    );
  }
}

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
    return Row(
      mainAxisAlignment:
          isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 155,
          child: Column(
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
              CustomText(
                zone.name,
                fontSize: 30,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
