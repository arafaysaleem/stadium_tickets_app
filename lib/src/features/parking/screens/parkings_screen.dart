import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Router
import '../../../config/routing/routing.dart';

// Providers
import '../providers/parking_spaces_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/parking_floors_list.dart';
import '../widgets/parking_spaces_area.dart';

class ParkingsScreen extends ConsumerWidget {
  const ParkingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH10,

            // Icon and title row
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Row(
                children: [
                  CustomBackIcon(
                    onTap: () {
                      AppRouter.pop();
                      ref.read(selectedSpacesProvider.notifier).clear();
                    },
                  ),

                  // Parking Floor
                  const Expanded(
                    child: CustomText(
                      'Pick Parking Spot',
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 30),
                ],
              ),
            ),

            Insets.gapH15,

            // Floors List
            const ParkingFloorsList(),

            Insets.gapH15,

            // Spots
            const Expanded(
              child: ParkingSpacesArea(),
            ),
          ],
        ),
      ),
    );
  }
}
