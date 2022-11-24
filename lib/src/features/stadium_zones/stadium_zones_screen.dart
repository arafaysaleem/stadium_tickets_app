import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';

// Router
import '../../config/routes/app_router.dart';

// Providers
import '../events/providers/events_provider.dart';
import 'providers/zones_provider.dart';

// Widgets
import '../../global/widgets/custom_back_icon.dart';
import '../../global/widgets/custom_text.dart';
import 'widgets/zone_info_card.dart';
import 'widgets/stadium.dart';

class StadiumZonesScreen extends ConsumerWidget {
  const StadiumZonesScreen({super.key});

  bool isLeftZone(int? zoneNumber) {
    return [8, 5, 9, 4].contains(zoneNumber);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(currentEventProvider);
    final selectedZoneNo = ref.watch(currentZoneNoProvider);
    final isSelected = selectedZoneNo != null;
    final slideRight = isLeftZone(selectedZoneNo);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Shaded background
            const SizedBox(
              height: 250,
              width: double.infinity,
              child: ColoredBox(color: AppColors.backgroundColor),
            ),

            // Back Icon And Title
            Positioned(
              top: 15,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  CustomBackIcon(
                    onTap: () {
                      AppRouter.pop();
                      ref.read(currentEventProvider.notifier).state = null;
                    },
                  ),

                  const Spacer(flex: 3),

                  // Event Name
                  CustomText.title(event?.name ?? ''),

                  const Spacer(flex: 4)
                ],
              ),
            ),

            // Select zone message
            Positioned(
              top: 60,
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
              top: 95,
              isSelected: isSelected,
              slideRight: slideRight,
            ),

            // Red line
            const Positioned(
              top: 265,
              left: 0,
              right: 0,
              height: 3,
              child: ColoredBox(
                color: AppColors.redColor,
              ),
            ),

            // Stadium
            Stadium(
              top: 95,
              isSelected: isSelected,
              slideRight: slideRight,
            ),
          ],
        ),
      ),
    );
  }
}
