import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';
import 'dashed_ticket_separator.dart';
import 'show_details_section.dart';
import 'ticket_details_list.dart';

// Features
import '../../../events/events.dart';

class TicketsSummaryBox extends StatelessWidget {
  const TicketsSummaryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.rounded10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Event Picture
          Consumer(
            builder: (ctx, ref, _) {
              final selectedEventPoster = ref.watch(
                currentEventProvider.select((value) => value!.posterUrl),
              );
              return CustomNetworkImage(
                imageUrl: selectedEventPoster,
                height: 180,
                fit: BoxFit.cover,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                placeholder: const EventPosterPlaceholder(),
                errorWidget: const EventPosterPlaceholder(),
              );
            },
          ),

          // Event details
          const ShowDetailsSection(),

          // Separator
          const DashedTicketSeparator(),

          // Ticket details
          const Expanded(
            child: TicketDetailsList(),
          ),

          // Expand icon
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Icon(Icons.expand_more_sharp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
