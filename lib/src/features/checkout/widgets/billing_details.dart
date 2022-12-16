import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

// Providers
import '../providers/checkout_provider.dart';

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
    final totalAmount = ref.watch(totalAmountProvider);
    final ticketsSummary = ref.watch(ticketsSummaryProvider);
    final selectedSeats = ticketsSummary.seatTickets;
    final selectedSpaces = ticketsSummary.parkingTickets;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Billing Details Label
        CustomText.body(
          'Billing Details',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlackColor,
        ),

        Insets.gapH10,

        // Event Details
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: Corners.rounded10,
          ),
          child: Row(
            children: [
              // Event Picture
              CustomNetworkImage(
                imageUrl: event.posterUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
                placeholder: const MoviePosterPlaceholder(),
                errorWidget: const MoviePosterPlaceholder(),
              ),

              // Event Title
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomText(
                    event.name,
                    fontSize: 16,
                    maxLines: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        Insets.gapH15,

        // Billing Summary Labels
        Row(
          children: const [
            CustomText(
              'Ticket Type',
              color: AppColors.textBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Insets.expand,
            SizedBox(
              width: 40,
              child: CustomText(
                'Qty',
                color: AppColors.textBlackColor,
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Insets.gapW10,
            CustomText(
              'Price',
              color: AppColors.textBlackColor,
              fontSize: 16,
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
            CustomText(
              '$ticketPrice',
              fontSize: 15,
              color: AppColors.textGreyColor,
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
              CustomText(
                '$ticketPrice',
                fontSize: 15,
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
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
