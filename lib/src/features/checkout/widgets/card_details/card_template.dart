import 'package:flutter/material.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class CardTemplate extends StatelessWidget {
  final TextEditingController cardholderNameController;
  final TextEditingController cardCVVController;
  final TextEditingController cardNumberController;
  final TextEditingController cardExpiryController;

  const CardTemplate({
    super.key,
    required this.cardholderNameController,
    required this.cardCVVController,
    required this.cardNumberController,
    required this.cardExpiryController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: Corners.rounded20,
        color: AppColors.surfaceColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Card Handler Icon
          const Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.card_giftcard,
              color: AppColors.textBlackColor,
              size: 30,
            ),
          ),

          Insets.expand,

          // Card Number Input
          CustomTextField(
            controller: cardNumberController,
            floatingText: 'CARD NUMBER',
            hintText: 'XXXX XXXX XXXX XXXX',
            floatingStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.textGreyColor,
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: FormValidator.cardNumberValidator,
          ),

          Insets.gapH(40),

          // Card Name, Expiry and CVV
          Row(
            children: [
              // Card Name Input
              Expanded(
                flex: 4,
                child: CustomTextField(
                  controller: cardholderNameController,
                  floatingText: 'CARDHOLDER NAME',
                  floatingStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyColor,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.nameValidator,
                ),
              ),

              // Card Expiry Input
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: cardExpiryController,
                  floatingText: 'VALID THRU',
                  floatingStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyColor,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.cardExpiryValidator,
                ),
              ),

              // Card CVV Input
              Expanded(
                child: CustomTextField(
                  controller: cardCVVController,
                  floatingText: 'CVV',
                  floatingStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyColor,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: FormValidator.cardCVVValidator,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
