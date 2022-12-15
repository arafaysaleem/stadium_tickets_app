import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class PayButton extends ConsumerWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const cardAdded = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {},
        disabled: !cardAdded,
        gradient: AppColors.buttonGradientPrimary,
        child: const Center(
          child: Text(
            'PAY',
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
