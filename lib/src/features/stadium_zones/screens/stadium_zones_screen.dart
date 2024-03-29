import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Router
import '../../../config/routing/routing.dart';

// Providers
import '../../../helpers/extensions/extensions.dart';
import '../providers/zones_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/zone_info_card.dart';
import '../widgets/stadium.dart';

// Features
import '../../events/events.dart';

class StadiumZonesScreen extends ConsumerWidget {
  const StadiumZonesScreen({super.key});

  bool isLeftZone(int? zoneNumber) {
    return [8, 5, 9, 4].contains(zoneNumber);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(currentEventProvider);
    final selectedZoneNo = ref.watch(
      currentZoneProvider.select((value) => value?.number),
    );
    final isSelected = selectedZoneNo != null;
    final slideRight = isLeftZone(selectedZoneNo);
    const stadiumOffset = 20.0;
    final stadiumHeight = context.screenHeight * 0.7;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Back Icon And Title
            Positioned(
              top: 15,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackIcon(
                    onTap: () {
                      AppRouter.pop();
                      ref.invalidate(currentEventProvider);
                    },
                  ),

                  // Event Name
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(
                        event?.name ?? '',
                        fontSize: 19,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Select zone message
            Positioned(
              bottom: stadiumOffset + stadiumHeight + 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText.body('Select your zone'),
                ],
              ),
            ),

            // Zone Info
            ZoneInfoCard(
              offset: stadiumOffset + stadiumHeight - 450,
              height: 450,
              isSelected: isSelected,
              slideRight: slideRight,
            ),

            // Red line
            Positioned(
              bottom: stadiumOffset + stadiumHeight - 135,
              left: 0,
              right: 0,
              height: 3,
              child: const ColoredBox(
                color: AppColors.redColor,
              ),
            ),

            // Stadium
            Stadium(
              offset: stadiumOffset,
              height: stadiumHeight,
              isSelected: isSelected,
              slideRight: slideRight,
            ),
          ],
        ),
      ),
    );
  }
}
