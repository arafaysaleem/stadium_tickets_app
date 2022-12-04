import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';
import '../../../helpers/extensions/extensions.dart';

// Enums
import '../enums/seat_indicator_enum.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SeatColorIndicators extends StatelessWidget {
  const SeatColorIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var indicator in SeatIndicator.values)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Color indicator circle
                SizedBox(
                  height: 9,
                  width: 9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: indicator.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Insets.gapW10,

                // Label
                CustomText.subtitle(
                  indicator.name.capitalize,
                ),
              ],
            )
        ],
      ),
    );
  }
}
