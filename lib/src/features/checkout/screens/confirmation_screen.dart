import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../enums/checkout_state_enum.dart';
import '../../../helpers/constants/constants.dart';

// Providers
import '../providers/checkout_provider.codegen.dart';

// Widgets
import '../../../global/widgets/custom_circular_loader.dart';
import '../widgets/confirmation/more_bookings_button.dart';
import '../widgets/confirmation/retry_payment_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => true,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.buttonGradientDanger,
            ),
            padding: EdgeInsets.only(bottom: Insets.bottomInsetsLow.height! + 5),
            child: Consumer(
              builder: (ctx, ref, child) {
                final state = ref.watch(checkoutProvider);
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchInCurve: Curves.easeInBack,
                  child: state.when(
                    loading: () => const CustomCircularLoader(),
                    data: (status) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Insets.expand,
      
                        // Loading
                        if (status == CheckoutState.SUCCESS)
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 64,
                          )
                        else
                          const SpinKitPouringHourGlass(
                            color: Colors.white,
                            duration: Duration(milliseconds: 1100),
                            size: 64,
                          ),
      
                        const SizedBox(height: 10),
      
                        // Text
                        Expanded(
                          child: Text(
                            status == CheckoutState.SUCCESS
                                ? 'Your tickets have been booked!'
                                : status == CheckoutState.CONFIRMING_BOOKING
                                    ? 'Confirming booking'
                                    : 'Processing payment',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
      
                        if (status == CheckoutState.SUCCESS) const MoreBookingsButton(),
                      ],
                    ),
                    error: (reason, st) => Column(
                      key: const ValueKey('error'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Insets.expand,
      
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 64,
                        ),
      
                        SizedBox(height: 10),
      
                        // Text
                        Expanded(
                          child: Text(
                            'Payment Failed',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
      
                        RetryPaymentButton(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
