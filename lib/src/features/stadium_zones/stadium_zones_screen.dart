import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';

// Router
import '../../config/routes/app_router.dart';
import '../../config/routes/routes.dart';

// Providers
import '../events/providers/events_provider.dart';

// Widgets
import '../../global/widgets/custom_back_icon.dart';
import '../../global/widgets/custom_text.dart';
import '../../global/widgets/custom_text_button.dart';

class StadiumZonesScreen extends ConsumerWidget {
  const StadiumZonesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(currentEventProvider);
    final coords = <double>[0, 1, 0, -1];
    return Scaffold(
      body: SafeArea(
        child: Stack(
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

            // Red line
            const Positioned(
              top: 250,
              left: 0,
              right: 0,
              height: 3,
              child: ColoredBox(
                color: AppColors.primaryColor,
              ),
            ),

            // Stadium
            Align(
              child: _OuterGreyLayer(
                child: _MiddleGreyLayer(
                  child: Stack(
                    children: [
                      // Green ground
                      const _InnerGreyLayer(
                        child: _GreenGround(),
                      ),

                      // Zones Overlay
                      for (int i = 0; i < coords.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment(
                              coords[i],
                              coords[coords.length - i - 1],
                            ),
                            child: ZoneNumberBox(number: i),
                          ),
                        )
                    ],
                  ),
                ),
              ),
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

class _OuterGreyLayer extends StatelessWidget {
  final Widget child;

  const _OuterGreyLayer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 520,
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(70),
        color: const Color(0xFFF5F6FA),
        boxShadow: Shadows.universalDark,
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: child,
    );
  }
}

class _MiddleGreyLayer extends StatelessWidget {
  final Widget child;

  const _MiddleGreyLayer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(65),
        color: const Color(0xFFEBEDF5),
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

class _InnerGreyLayer extends StatelessWidget {
  final Widget child;

  const _InnerGreyLayer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.rounded(60),
        color: const Color(0xFFE2E5F0),
      ),
      padding: const EdgeInsets.all(45),
      child: child,
    );
  }
}

class _GreenGround extends StatelessWidget {
  const _GreenGround();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded(15),
          color: Colors.green.shade800,
        ),
      ),
    );
  }
}

class ZoneNumberBox extends StatelessWidget {
  final int number;

  const ZoneNumberBox({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: Corners.rounded4,
        color: Color(0xFFCCCFDC),
      ),
      height: 25,
      width: 25,
      child: Center(
        child: CustomText.subtitle(
          '$number',
          color: const Color(0xFF585A5F),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
