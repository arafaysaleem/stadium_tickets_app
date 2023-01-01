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

    ref.listen(
      bookingSummaryProvider,
      (_, state) => state.whenOrNull(
        data: (_) => AppRouter.pushNamed(Routes.CheckoutScreenRoute),
        error: (reason, st) => CustomDialog.showAlertDialog(
          context: context,
          reason: reason as String,
          dialogTitle: 'Booking Reservation Failed',
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.gradient(
        width: double.infinity,
        disabled: !ticketDetailsAdded,
        onPressed: () {
          ref.read(bookingSummaryProvider.notifier).reserveBooking();
        },
        gradient: AppColors.buttonGradientPrimary,
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(bookingSummaryProvider);
            return state.maybeWhen(
              loading: () => const CustomCircularLoader(
                color: Colors.white,
                size: 20,
              ),
              orElse: () => child!,
            );
          },
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
        ),
      ),
    );
  }
}
