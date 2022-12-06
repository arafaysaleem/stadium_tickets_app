import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'dashed_ticket_separator.dart';

// Features
import '../../stadium_zones/stadium_zones.dart';
import '../../zone_seats/zone_seats.dart';

class TicketDetailsList extends ConsumerWidget {
  const TicketDetailsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSeatNames = ref.watch(
      selectedSeatsProvider.notifier.select((value) => value.seatNames),
    );
    final ticketPrice = ref.watch(
      currentZoneProvider.select((value) => value!.type.price),
    );
    return ListView.separated(
      itemCount: selectedSeatNames.length,
      separatorBuilder: (_, i) => const DashedTicketSeparator(),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Seat icon
            const Icon(
              Icons.event_seat_sharp,
              color: AppColors.primaryColor,
            ),

            // Seat
            LabeledWidget(
              label: 'Seat',
              labelStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.textGreyColor,
              ),
              child: CustomText(
                selectedSeatNames[i],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Price
            LabeledWidget(
              label: 'Price',
              labelStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.textGreyColor,
              ),
              child: CustomText(
                'Rs. $ticketPrice',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
