import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../enums/card_provider_enum.dart';

// Widgets
import 'card_cvv_input_field.dart';
import 'card_expiry_input_field.dart';
import 'card_handler_dropdown.dart';
import 'card_holder_name_input_field.dart';
import 'card_number_input_field.dart';

class CardTemplate extends StatelessWidget {
  final TextEditingController cardholderNameController;
  final TextEditingController cardCVVController;
  final TextEditingController cardNumberController;
  final TextEditingController cardExpiryController;
  final ValueNotifier<CardProvider> cardProviderController;

  const CardTemplate({
    super.key,
    required this.cardholderNameController,
    required this.cardCVVController,
    required this.cardProviderController,
    required this.cardNumberController,
    required this.cardExpiryController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: Corners.rounded20,
        color: AppColors.surfaceColor,
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 3),
      child: Column(
        children: [
          // Card Handler Icon
          CardHandlerDropdown(
            cardProviderController: cardProviderController,
          ),

          Insets.gapH5,

          // Card Number Input
          CardNumberInputField(
            cardNumberController: cardNumberController,
          ),

          Insets.gapH15,

          // Card Name, Expiry and CVV
          Row(
            children: [
              // Card Name Input
              Expanded(
                flex: 6,
                child: CardHolderNameInputField(
                  cardholderNameController: cardholderNameController,
                ),
              ),

              Insets.gapW10,

              // Card Expiry Input
              Expanded(
                flex: 3,
                child: CardExpiryInputField(
                  cardExpiryController: cardExpiryController,
                ),
              ),

              Insets.gapW10,

              // Card CVV Input
              Expanded(
                flex: 2,
                child: CardCvvInputField(
                  cardCVVController: cardCVVController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
