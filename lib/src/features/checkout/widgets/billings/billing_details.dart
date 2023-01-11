import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Features
import '../../../events/events.dart';
import '../../../stadium_zones/stadium_zones.dart';
import '../../../booking_summary/booking_summary.dart';

class BillingDetails extends ConsumerWidget {
  const BillingDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketPrice = ref.watch(
      currentZoneProvider.select((value) => value!.type.price),
    );
    final event = ref.watch(currentEventProvider)!;
    final totalAmount = ref.watch(totalAmountProvider);
    final selectedSeats = ref.watch(seatTicketsProvider);
    final selectedSpaces = ref.watch(parkingTicketsProvider);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.rounded10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Poster
          CustomNetworkImage(
            imageUrl: event.posterUrl,
            height: 170,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            placeholder: const EventPosterPlaceholder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            errorWidget: const EventPosterPlaceholder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),

          // Event Title
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    event.name,
                    fontSize: 20,
                    maxLines: 3,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const DashedTicketSeparator(),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Billing Details Label
                const CustomText(
                  'Billing Details',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlackColor,
                ),

                Insets.gapH10,

                // Billing Summary Labels
                Row(
                  children: const [
                    CustomText(
                      'Ticket Type',
                      color: AppColors.textBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    Insets.expand,
                    SizedBox(
                      width: 40,
                      child: CustomText(
                        'Qty',
                        color: AppColors.textBlackColor,
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Insets.gapW10,
                    CustomText(
                      'Price',
                      color: AppColors.textBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),

                Insets.gapH10,

                // Seat Summary Data
                Row(
                  children: [
                    // Type
                    const CustomText(
                      'Seat',
                      fontSize: 15,
                      color: AppColors.textGreyColor,
                    ),

                    Insets.expand,

                    // Num of tickets
                    SizedBox(
                      width: 40,
                      child: CustomText(
                        '${selectedSeats.length}',
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        color: AppColors.textGreyColor,
                      ),
                    ),

                    Insets.gapW10,

                    // Price
                    SizedBox(
                      width: 35,
                      child: CustomText(
                        '$ticketPrice',
                        fontSize: 15,
                        textAlign: TextAlign.right,
                        color: AppColors.textGreyColor,
                      ),
                    )
                  ],
                ),

                Insets.gapH5,

                // Parking Summary Data
                if (selectedSpaces.isNotEmpty)
                  Row(
                    children: [
                      // Type
                      const CustomText(
                        'Parking',
                        fontSize: 15,
                        color: AppColors.textGreyColor,
                      ),

                      Insets.expand,

                      // Num of tickets
                      SizedBox(
                        width: 40,
                        child: CustomText(
                          '${selectedSpaces.length}',
                          textAlign: TextAlign.center,
                          fontSize: 15,
                          color: AppColors.textGreyColor,
                        ),
                      ),

                      Insets.gapW10,

                      // Price
                      SizedBox(
                        width: 35,
                        child: CustomText(
                          '$ticketPrice',
                          fontSize: 15,
                          textAlign: TextAlign.right,
                          color: AppColors.textGreyColor,
                        ),
                      )
                    ],
                  ),

                const Divider(color: Colors.black, thickness: 0.8),

                // Billing Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText.body(
                      'Total - \$$totalAmount',
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
