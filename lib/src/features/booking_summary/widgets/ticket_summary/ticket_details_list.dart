import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/booking_summary_provider.codegen.dart';

// Widgets
import 'buyer_details_section.dart';
import 'dashed_ticket_separator.dart';
import 'seat_ticket.dart';
import 'space_ticket.dart';

class TicketDetailsList extends ConsumerWidget {
  const TicketDetailsList({super.key});

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.82, 1],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSeats = ref.watch(seatTicketsProvider);
    final selectedSpaces = ref.watch(parkingTicketsProvider);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ShaderMask(
        shaderCallback: getShader,
        blendMode: BlendMode.dstOut,
        child: ListView.separated(
          itemCount: selectedSeats.length + selectedSpaces.length,
          padding: const EdgeInsets.only(bottom: 25),
          separatorBuilder: (_, i) => const DashedTicketSeparator(),
          itemBuilder: (_, i) {
            final isSeatTicket = i < selectedSeats.length;
            final index = isSeatTicket ? i : i - selectedSeats.length;
            Widget child = isSeatTicket
                ? SeatTicket(
                    index: index,
                    seatTicketModel: selectedSeats[index],
                  )
                : SpaceTicket(
                    parkingTicketModel: selectedSpaces[index],
                  );

            if (i == 0) {
              child = Column(
                children: [
                  // Event details
                  const BuyerDetailsSection(),

                  // Separator
                  const DashedTicketSeparator(),

                  // Ticket details
                  child,
                ],
              );
            }

            return child;
          },
        ),
      ),
    );
  }
}
