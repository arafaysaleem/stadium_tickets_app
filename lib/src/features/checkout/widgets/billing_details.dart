import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

// Features
import '../../events/events.dart';
import '../../stadium_zones/stadium_zones.dart';
import '../../tickets_summary/tickets_summary.dart';

class BillingDetails extends ConsumerWidget {
  const BillingDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketPrice = ref.watch(
      currentZoneProvider.select((value) => value!.type.price),
    );
    final event = ref.watch(currentEventProvider)!;
    final ticketsSummary = ref.watch(ticketsSummaryProvider);
    final selectedSeats = ticketsSummary.seatTickets;
    final selectedSpaces = ticketsSummary.parkingTickets;
    final totalAmount = selectedSeats.length * ticketPrice +
        selectedSpaces.length * ticketPrice;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Billing Details Label
          const Text(
            'Billing Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),

          Insets.gapH15,

          // Billing Summary Labels
          Row(
            children: const [
              Text(
                'Ticket Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Insets.gapW10,
              SizedBox(
                width: 40,
                child: Text(
                  'Qty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Insets.expand,
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          Insets.gapH15,

          // Event Title
          CustomText.body(
            event.name,
            fontSize: 18,
            color: AppColors.textBlackColor,
          ),

          Insets.gapH15,

          // Seat Summary Data
          Row(
            children: [
              // Type
              CustomText.body(
                'Seat',
                color: AppColors.textGreyColor,
              ),

              Insets.gapW10,

              // Num of tickets
              SizedBox(
                width: 40,
                child: CustomText(
                  '${selectedSeats.length}',
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  color: AppColors.textGreyColor,
                ),
              ),

              Insets.expand,

              // Price
              CustomText.body(
                '$ticketPrice',
                color: AppColors.textGreyColor,
              )
            ],
          ),

          Insets.gapH10,

          // Parking Summary Data
          if (selectedSpaces.isNotEmpty)
            Row(
              children: [
                // Type
                CustomText.body(
                  'Parking',
                  color: AppColors.textGreyColor,
                ),

                Insets.gapW10,

                // Num of tickets
                SizedBox(
                  width: 40,
                  child: CustomText(
                    '${selectedSpaces.length}',
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    color: AppColors.textGreyColor,
                  ),
                ),

                Insets.expand,

                // Price
                CustomText.body(
                  '$ticketPrice',
                  color: AppColors.textGreyColor,
                )
              ],
            ),

          const Divider(color: Colors.black, thickness: 0.8),

          // Billing Total
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText.body(
                'Total - Rs. $totalAmount',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
