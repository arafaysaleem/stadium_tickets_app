import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../config/routing/routing.dart';
import '../../../../helpers/constants/constants.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Features
import '../../checkout.dart';

class PayButton extends ConsumerWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAdded = ref.watch(
      savedCardDetailsProvider.select((value) => value != null),
    );
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        ref.read(checkoutProvider.notifier).makeCheckoutPayment();
        AppRouter.pushNamed(Routes.ConfirmationScreenRoute);
      },
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
    );
  }
}
