import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/parking_floor_model.codegen.dart';

// Providers
import '../providers/parking_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class ParkingFloorListItem extends ConsumerWidget {
  final ParkingFloorModel parking;

  const ParkingFloorListItem({
    super.key,
    required this.parking,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentParkingFloorProvider.select((value) => value == parking),
    );
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          ref.read(currentParkingFloorProvider.notifier).state = parking;
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
          child: CustomText.subtitle('Level $parking'),
        ),
      ),
    );
  }
}
