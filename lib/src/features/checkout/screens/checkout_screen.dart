import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/billing_details.dart';
import '../widgets/pay_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              Insets.gapH20,

              // Back icon and title
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Row(
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
              ),

              Insets.gapH20,

              // Bill Details White Box
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: Corners.rounded10,
                ),
                child: const BillingDetails(),
              ),

              Insets.gapH20,

              // Payment Details Black Box
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: Corners.rounded10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Payment Mode Label
                      CustomText.title(
                        'Payment Mode',
                        color: AppColors.textWhite80Color,
                      ),

                      Insets.gapH10,

                      // Card details
                      CustomText.body(
                        '+ Add New Card',
                        color: AppColors.textWhite80Color,
                      ),
                    ],
                  ),
                ),
              ),

              Insets.gapH20,

              // Pay Button
              const PayButton(),

              Insets.gapH5,
            ],
          ),
        ),
      ),
    );
  }
}
