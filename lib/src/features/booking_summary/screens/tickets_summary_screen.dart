import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Providers
import '../../food/providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/confirm_bookings_button.dart';
import '../widgets/ticket_summary/tickets_summary_box.dart';

// Features
import '../../parking/parking.dart';

class TicketSummaryScreen extends StatelessWidget {
  const TicketSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back icon and title
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
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

            Insets.gapH15,

            // Tickets Box
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TicketsSummaryBox(),
              ),
            ),

            Insets.gapH15,

            // Extras
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Parking Add on
                  InkResponse(
                    onTap: () {
                      AppRouter.pushNamed(Routes.ParkingsScreenRoute);
                    },
                    child: Consumer(
                      builder: (_, ref, __) {
                        final hasParking =
                            ref.watch(parkingSpacesProvider).isNotEmpty;
                        return Row(
                          children: [
                            // Parking Icon
                            const Icon(
                              Icons.local_parking_rounded,
                              color: AppColors.primaryColor,
                            ),

                            Insets.gapW10,

                            // Add on label
                            CustomText.body(
                              hasParking ? 'Edit parking' : 'Buy parking',
                              color: AppColors.primaryColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Food Add on
                  InkResponse(
                    onTap: () {
                      AppRouter.pushNamed(Routes.FoodScreenRoute);
                    },
                    child: Consumer(
                      builder: (_, ref, __) {
                        final hasFood =
                            ref.watch(categorySnacksProvider).isNotEmpty;
                        return Row(
                          children: [
                            // Food Icon
                            const Icon(
                              Icons.fastfood_rounded,
                              color: AppColors.primaryColor,
                            ),

                            Insets.gapW10,

                            // Add on label
                            CustomText.body(
                              hasFood ? 'Edit food' : 'Buy food',
                              color: AppColors.primaryColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Insets.gapH15,

            // Confirm Button
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ConfirmBookingsButton(),
            ),

            Insets.gapH15,
          ],
        ),
      ),
    );
  }
}
