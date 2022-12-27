import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/seat_ticket_model.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../tickets_summary.dart';

class SeatTicket extends StatelessWidget {
  const SeatTicket({
    super.key,
    required this.seatTicketModel,
    required this.index,
  });

  final SeatTicketModel seatTicketModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDetailAdded = seatTicketModel.personId != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      height: 105,
      color: isDetailAdded ? Colors.white : AppColors.greyOutlineColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Seat
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Seat icon
                Icon(
                  Icons.event_seat_rounded,
                  color: isDetailAdded
                      ? AppColors.primaryColor
                      : AppColors.darkSkeletonColor,
                ),

                // Seat/Space
                LabeledWidget(
                  label: 'Seat',
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGreyColor,
                  ),
                  child: CustomText(
                    seatTicketModel.seatModel.name,
                    fontSize: 15,
                    color: isDetailAdded
                        ? AppColors.textBlackColor
                        : AppColors.darkSkeletonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Person Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Person Name
              LabeledWidget(
                label: 'Full Name',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  seatTicketModel.personName ?? 'To Be Added',
                  fontSize: 15,
                  color: isDetailAdded
                      ? AppColors.textBlackColor
                      : AppColors.darkSkeletonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Person Id
              LabeledWidget(
                label: 'Identity No.',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  seatTicketModel.personId ?? 'To Be Added',
                  fontSize: 15,
                  color: isDetailAdded
                      ? AppColors.textBlackColor
                      : AppColors.darkSkeletonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Add/Edit Details Button
          Consumer(
            builder: (context, ref, child) {
              return CustomTextButton.gradient(
                gradient: AppColors.buttonGradientPrimary,
                width: 44,
                height: 27,
                onPressed: () {
                  ref.read(ticketsSummaryProvider.notifier).update(
                    (state) {
                      return state.copyWith(
                        seatTickets: [
                          for (int i = 0; i < state.seatTickets.length; i++)
                            if (i == index)
                              state.seatTickets[index].copyWith(
                                personId:
                                    isDetailAdded ? null : '42201-2909561-5',
                                personName: isDetailAdded ? null : 'John Doe',
                              )
                            else
                              state.seatTickets[i]
                        ],
                      );
                    },
                  );
                },
                child: Center(
                  child: CustomText(
                    fontSize: 13,
                    isDetailAdded ? 'Edit' : 'Add',
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
