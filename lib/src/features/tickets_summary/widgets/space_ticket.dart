import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/parking_ticket_model.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SpaceTicket extends StatelessWidget {
  final ParkingTicketModel parkingTicketModel;

  const SpaceTicket({
    super.key,
    required this.parkingTicketModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Seat
          const Icon(
            Icons.local_parking_rounded,
            color: AppColors.primaryColor,
          ),

          // Floor
          LabeledWidget(
            label: 'Floor',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              'Level ${parkingTicketModel.floorNo}',
              fontSize: 15,
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Seat/Space
          LabeledWidget(
            label: 'Space',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              parkingTicketModel.spaceModel.toName(),
              fontSize: 15,
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
