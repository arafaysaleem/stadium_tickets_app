import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class BookParkingButton extends StatelessWidget {
  const BookParkingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.outlined(
        width: double.infinity,
        onPressed: () {
          AppRouter.pushNamed(Routes.ParkingsScreenRoute);
        },
        border: Border.all(
          width: 2,
          color: AppColors.primaryColor,
        ),
        child: const Center(
          child: Text(
            'BOOK PARKING',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
