import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

// Widgets
import '../../../global/widgets/custom_text_button.dart';

class PurchaseSeatsButton extends StatelessWidget {
  const PurchaseSeatsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer(
        builder: (ctx, ref, _) {
          // final theaterSeats = ref.watch(theatersProvider).selectedSeats.length;
          const theaterSeats = 0;
          return CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {},
            disabled: theaterSeats == 0,
            gradient: AppColors.buttonGradientPrimary,
            child: const Center(
              child: Text(
                'PURCHASE - $theaterSeats SEATS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
