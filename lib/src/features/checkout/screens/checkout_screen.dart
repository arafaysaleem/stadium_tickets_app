import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/billing_details.dart';
import '../widgets/pay_button.dart';
import '../widgets/payment_details.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollableColumn(
              children: [
                Insets.gapH20,

                // Back icon and title
                Row(
                  children: const [
                    CustomBackIcon(
                      onTap: AppRouter.pop,
                    ),

                    // Title
                    Expanded(
                      child: CustomText(
                        'Checkout Summary',
                        fontSize: 22,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Insets.gapW30,
                  ],
                ),

                Insets.gapH20,

                // Bill Details White Box
                const BillingDetails(),

                Insets.gapH20,

                // Payment Details Black Box
                const PaymentDetails(),

                Insets.expand,

                // Pay Button
                const PayButton(),

                Insets.bottomInsetsLow,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
