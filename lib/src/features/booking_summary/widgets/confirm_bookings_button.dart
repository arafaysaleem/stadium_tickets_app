import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Providers
import '../providers/booking_summary_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class ConfirmBookingsButton extends ConsumerWidget {
  const ConfirmBookingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketDetailsAdded = ref.watch(
      seatTicketsProvider.select(
        (value) =>
            value.every((element) => element.identificationNumber != null),
      ),
    );

    final buyerDetailsAdded = ref.watch(
      buyerEmailProvider.select((value) => value != null && value.isNotEmpty),
    );

    return CustomTextButton.gradient(
      width: double.infinity,
      disabled: !ticketDetailsAdded || !buyerDetailsAdded,
      onPressed: () {
        AppRouter.pushNamed(Routes.CheckoutScreenRoute);
      },
      gradient: AppColors.buttonGradientPrimary,
      child: const Center(
        child: Text(
          'CONFIRM',
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
