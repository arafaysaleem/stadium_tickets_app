import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Providers
import '../../providers/checkout_provider.codegen.dart';

class RetryPaymentButton extends ConsumerWidget {
  const RetryPaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.outlined(
        width: double.infinity,
        onPressed: () {
          ref.read(checkoutProvider.notifier).makeCheckoutPayment();
        },
        border: Border.all(
          width: 4,
          color: AppColors.textWhite80Color,
        ),
        child: const Center(
          child: Text(
            'RETRY PAYMENT',
            style: TextStyle(
              color: AppColors.textWhite80Color,
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
