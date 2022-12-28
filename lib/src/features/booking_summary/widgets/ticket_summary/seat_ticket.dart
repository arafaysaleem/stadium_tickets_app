import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Models
import '../../models/booking_seat_model.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';
import '../ticket_details/ticket_details_bottom_sheet.dart';

class SeatTicket extends StatelessWidget {
  const SeatTicket({
    super.key,
    required this.seatTicketModel,
    required this.index,
  });

  final BookingSeatModel seatTicketModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDetailAdded = seatTicketModel.identificationNumber != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      height: 105,
      color: isDetailAdded ? Colors.white : AppColors.greyOutlineColor,
      child: Row(
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
                    '${seatTicketModel.seatRow}-${seatTicketModel.seatNumber}',
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

          Insets.gapW(35),

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
                  seatTicketModel.identificationNumber ?? 'To Be Added',
                  fontSize: 15,
                  color: isDetailAdded
                      ? AppColors.textBlackColor
                      : AppColors.darkSkeletonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Insets.expand,

          // Add/Edit Details Button
          Consumer(
            builder: (context, ref, child) {
              return CustomTextButton.gradient(
                gradient: AppColors.buttonGradientPrimary,
                width: 44,
                height: 27,
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (_) => TicketDetailsBottomSheet(
                      index: index,
                      seatTicket: seatTicketModel,
                    ),
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
