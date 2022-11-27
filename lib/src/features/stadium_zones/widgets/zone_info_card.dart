import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_utils.dart';

// Widgets
import 'zone_details.dart';

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
