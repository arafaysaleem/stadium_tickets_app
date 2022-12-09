import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Providers
import '../providers/tickets_summary_provider.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'dashed_ticket_separator.dart';

// Features
import '../../stadium_zones/stadium_zones.dart';

class TicketDetailsList extends ConsumerWidget {
  const TicketDetailsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsSummary = ref.watch(ticketsSummaryProvider);
    final selectedSeats = ticketsSummary.seatTickets;
    final selectedSpaces = ticketsSummary.parkingTickets;
    final ticketPrice = ref.watch(
      currentZoneProvider.select((value) => value!.type.price),
    );
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.separated(
        itemCount: selectedSeats.length + selectedSpaces.length,
        separatorBuilder: (_, i) => const DashedTicketSeparator(),
        itemBuilder: (_, i) {
          final isSeatTicket = i < selectedSeats.length;
          final index = isSeatTicket ? i : i - selectedSeats.length;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Seat/Car icon
                Icon(
                  isSeatTicket
                      ? Icons.event_seat_rounded
                      : Icons.local_parking_rounded,
                  color: AppColors.primaryColor,
                ),

                // Floor
                if (!isSeatTicket)
                  LabeledWidget(
                    label: 'Floor',
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGreyColor,
                    ),
                    child: CustomText(
                      'Level ${selectedSpaces[index].floorNo}',
                      fontSize: 15,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                // Seat/Space
                LabeledWidget(
                  label: isSeatTicket ? 'Seat' : 'Space',
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGreyColor,
                  ),
                  child: CustomText(
                    isSeatTicket
                        ? selectedSeats[index].name
                        : selectedSpaces[index].spaceModel.toName(),
                    fontSize: 15,
                    color: AppColors.textBlackColor,
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
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
