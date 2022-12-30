import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Providers
import '../../providers/checkout_provider.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class PaymentDetails extends ConsumerWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardDetails = ref.watch(cardDetailsProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: Corners.rounded10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Mode Label
          const CustomText(
            'Payment Mode',
            fontSize: 18,
            color: AppColors.textWhite80Color,
            fontWeight: FontWeight.bold,
          ),

          Insets.gapH10,

          // Card details
          if (cardDetails == null)
            GestureDetector(
              onTap: () {
                AppRouter.pushNamed(Routes.CardSetupScreenRoute);
              },
              child: Row(
                children: const [
                  // Add Icon
                  Icon(
                    Icons.add_card_outlined,
                    size: 23,
                    color: AppColors.primaryColor,
                  ),

                  SizedBox(width: 10),

                  CustomText(
                    'Add New Card',
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                // Card Icon
                const Icon(
                  Icons.credit_card_outlined,
                  size: 23,
                  color: AppColors.textWhite80Color,
                ),

                Insets.gapW10,

                // Card Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        cardDetails.cardHolderName,
                        fontSize: 15,
                        color: AppColors.textWhite80Color,
                      ),
                      CustomText(
                        '**** **** **** ${cardDetails.cardNumber.toString().substring(12)}',
                        fontSize: 15,
                        color: AppColors.textWhite80Color,
                      ),
                    ],
                  ),
                ),

                // Edit Icon
                GestureDetector(
                  onTap: () {
                    ref.read(cardDetailsProvider.notifier).state = null;
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: AppColors.textWhite80Color,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
