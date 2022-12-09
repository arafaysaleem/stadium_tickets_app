import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/confirm_bookings_button.dart';
import '../widgets/tickets_summary_box.dart';

// Features
import '../../parking/parking.dart';

class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH20,

            // Back icon and title
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
              child: Row(
                children: const [
                  CustomBackIcon(
                    onTap: AppRouter.pop,
                  ),

                  // Page Name
                  Expanded(
                    child: CustomText(
                      'Your Tickets',
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Insets.gapW30,
                ],
              ),
            ),

            Insets.gapH20,

            // Tickets Box
            const TicketsSummaryBox(),

            Insets.expand,

            // Parking Extra
            InkResponse(
              onTap: () {
                AppRouter.pushNamed(Routes.ParkingsScreenRoute);
              },
              child: Consumer(
                builder: (_, ref, __) {
                  final hasParking =
                      ref.watch(parkingSpacesProvider).isNotEmpty;
                  return CustomText.body(
                    hasParking
                        ? 'Edit parking spaces'
                        : 'Want to book a parking spot? Click here.',
                    color: AppColors.primaryColor,
                  );
                },
              ),
            ),

            // Confirm Button
            const ConfirmBookingsButton(),

            Insets.gapH15,
          ],
        ),
      ),
    );
  }
}
