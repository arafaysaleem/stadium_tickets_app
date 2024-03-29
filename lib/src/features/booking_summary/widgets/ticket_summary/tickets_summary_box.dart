import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';
import 'show_details_section.dart';
import 'ticket_details_list.dart';

// Features
import '../../../events/events.dart';

class TicketsSummaryBox extends StatelessWidget {
  const TicketsSummaryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.rounded10,
      ),
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
                height: 100,
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
              );
            },
          ),

          // Event details
          const ShowDetailsSection(),

          // Separator
          const Divider(color: Colors.black, height: 4, thickness: 1),

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
            child: const Icon(
              Icons.expand_more_sharp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
