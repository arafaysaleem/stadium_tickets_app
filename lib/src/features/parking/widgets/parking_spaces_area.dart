import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/parking_floor_spaces_model.codegen.dart';

// Providers
import '../providers/parking_provider.codegen.dart';
import '../providers/parking_spaces_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'parking_spaces_grid.dart';

class ParkingSpacesArea extends ConsumerWidget {
  const ParkingSpacesArea({super.key});

  static const _spaceWidth = 68.0;
  static const _spaceGap = 11.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floor = ref.watch(currentParkingFloorProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      switchOutCurve: Curves.easeInBack,
      child: AsyncValueWidget<ParkingFloorSpacesModel?>(
        value: ref.watch(parkingSpacesFutureProvider(floor?.pFloorId)),
        data: (parkingSpacesModel) {
          final extendBottom = floor!.numOfRows > 11;
          final extendRight = floor.spacesPerRow > 7;
          return Column(
            children: [
              // Spaces Area
              ParkingSpacesGrid(
                spaceWidth: _spaceWidth,
                spaceGap: _spaceGap,
                extendRight: extendRight,
                extendBottom: extendBottom,
                numOfRows: floor.numOfRows,
                spacesPerRow: floor.spacesPerRow,
                floorNumber: floor.floorNumber,
                missing: parkingSpacesModel!.missing,
                blocked: parkingSpacesModel.blocked,
                booked: parkingSpacesModel.booked,
              ),

              if (!extendBottom) Insets.expand,

              // Selected Spaces Chips
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 0, 22),
                child: Consumer(
                  builder: (ctx, ref, child) {
                    final spaceNames = ref.watch(
                      currentFloorSelectedSpacesProvider.select(
                        (value) => value.map((e) => e.name).toList(),
                      ),
                    );
                    return CustomChipsList(
                      chipContents: spaceNames,
                      chipHeight: 27,
                      chipGap: 10,
                      fontSize: 14,
                      chipWidth: 60,
                      borderColor: AppColors.primaryColor,
                      contentColor: AppColors.primaryColor,
                      borderWidth: 1.5,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.3),
                      isScrollable: true,
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const CustomCircularLoader(),
        emptyOrNull: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () =>
              ref.refresh(parkingSpacesFutureProvider(floor?.pFloorId)),
          stackTrace: st,
        ),
      ),
    );
  }
}
