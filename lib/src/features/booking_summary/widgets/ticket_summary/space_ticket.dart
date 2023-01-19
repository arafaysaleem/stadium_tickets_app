import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Models
import '../../models/booking_parking_model.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class SpaceTicket extends StatelessWidget {
  final BookingParkingModel parkingTicketModel;

  const SpaceTicket({
    super.key,
    required this.parkingTicketModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        children: [
          // Space
          const Icon(
            Icons.local_parking_rounded,
            color: AppColors.primaryColor,
          ),

          Insets.gapW(40),

          // Floor
          LabeledWidget(
            label: 'Floor',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              'Level ${parkingTicketModel.floorNo}',
              fontSize: 14,
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          Insets.gapW(80),

          // Seat/Space
          LabeledWidget(
            label: 'Space',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              '${parkingTicketModel.spaceRow}-${parkingTicketModel.spaceNumber}',
              fontSize: 14,
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
