import 'package:collection/collection.dart';
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

            Insets.gapH10,

            // Extras
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Parking Add on
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkResponse(
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
                  ),

                  // Food Add on
                  Stack(
                    children: [
                      // Food button
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5),
                        child: InkResponse(
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
                      ),

                      // Food cart quantity
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Consumer(
                          builder: (_, ref, __) {
                            final totalSnacks = ref.watch(
                              categorySnacksProvider.select(
                                (catMap) => catMap.values.fold(
                                  0,
                                  (prev, snackMap) =>
                                      prev + snackMap.values.sum,
                                ),
                              ),
                            );
                            return totalSnacks > 0
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.textWhite80Color,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 19,
                                      minHeight: 19,
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        '$totalSnacks',
                                        fontSize: 11,
                                        color: AppColors.textBlackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Insets.shrink;
                          },
                        ),
                      ),
                    ],
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
