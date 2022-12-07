import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Providers
import '../providers/parking_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class ParkingFloorListItem extends ConsumerWidget {
  final int number;

  const ParkingFloorListItem({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentPFloorNoProvider.select((value) => value == number),
    );
    return InkWell(
      onTap: () {
        if (!isSelected) {
          ref.read(currentPFloorNoProvider.notifier).state = number;
        } else {
          ref.invalidate(currentPFloorNoProvider);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded15,
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.surfaceColor,
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: CustomText.label(
            'Level $number',
            color: isSelected
              ? AppColors.textWhite80Color
              : AppColors.textGreyColor,
          ),
        ),
      ),
    );
  }
}
