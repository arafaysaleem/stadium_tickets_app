import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';

// Router
import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';

// Providers
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_utils.dart';
import '../events/providers/events_provider.dart';

// Widgets
import '../../global/widgets/custom_back_icon.dart';
import '../../global/widgets/custom_text.dart';
import '../../global/widgets/custom_text_button.dart';
import 'providers/zones_provider.dart';
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
            AnimatedPositioned(
              duration: Durations.medium,
              top: 75,
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
                  decoration: BoxDecoration(
                    borderRadius: Corners.rounded(35),
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            // Red line
            const Positioned(
              top: 250,
              left: 0,
              right: 0,
              height: 3,
              child: ColoredBox(
                color: AppColors.redColor,
              ),
            ),

            // Stadium
            AnimatedPositioned(
              duration: Durations.medium,
              curve: Curves.fastOutSlowIn,
              top: 75,
              left: !isSelected
                  ? 0
                  : !slideRight
                      ? -185
                      : 185,
              right: !isSelected
                  ? 0
                  : slideRight
                      ? -185
                      : 185,
              child: const Stadium(),
            ),

            // View Seats
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: CustomTextButton.gradient(
                onPressed: () {
                  AppRouter.pushNamed(Routes.ZoneSeatsScreenRoute);
                },
                width: double.infinity,
                gradient: AppColors.buttonGradientPrimary,
                child: CustomText.body(
                  'View Seats',
                  color: AppColors.textWhite80Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
