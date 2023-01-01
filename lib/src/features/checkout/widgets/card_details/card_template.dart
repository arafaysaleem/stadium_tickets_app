import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/extensions/extensions.dart';
import '../../../../helpers/form_validator.dart';
import '../../enums/card_provider_enum.dart';

// Formatters
import '../../../../global/formatters/card_expiry_input_formatter.dart';
import '../../../../global/formatters/formatters.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

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
          CustomTextField(
            controller: cardNumberController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
            floatingText: 'CARD NUMBER',
            hintText: 'XXXX XXXX XXXX XXXX',
            showErrorMessage: false,
            showErrorBorder: true,
            hintStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.textGreyColor,
            ),
            floatingStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textGreyColor,
            ),
            inputStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.textWhite80Color,
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: FormValidator.cardNumberValidator,
          ),

          Insets.gapH15,

          // Card Name, Expiry and CVV
          Row(
            children: [
              // Card Name Input
              Expanded(
                flex: 6,
                child: CardHolderNameInput(
                  cardholderNameController: cardholderNameController,
                ),
              ),

              Insets.gapW10,

              // Card Expiry Input
              Expanded(
                flex: 3,
                child: CardExpiryInput(
                  cardExpiryController: cardExpiryController,
                ),
              ),

              Insets.gapW10,

              // Card CVV Input
              Expanded(
                flex: 2,
                child: CardCvvInput(
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

class CardCvvInput extends StatelessWidget {
  const CardCvvInput({
    super.key,
    required this.cardCVVController,
  });

  final TextEditingController cardCVVController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: cardCVVController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      hintText: 'XXX',
      floatingText: 'CVV',
      showErrorBorder: true,
      showErrorMessage: false,
      floatingStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textGreyColor,
      ),
      inputStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textWhite80Color,
      ),
      hintStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textGreyColor,
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: FormValidator.cardCVVValidator,
    );
  }
}

class CardExpiryInput extends StatelessWidget {
  const CardExpiryInput({
    super.key,
    required this.cardExpiryController,
  });

  final TextEditingController cardExpiryController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: cardExpiryController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardExpiryInputFormatter()
      ],
      hintText: 'MM / YY',
      floatingText: 'VALID THRU',
      showErrorBorder: true,
      showErrorMessage: false,
      floatingStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textGreyColor,
      ),
      inputStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textWhite80Color,
      ),
      hintStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textGreyColor,
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: FormValidator.cardExpiryValidator,
    );
  }
}

class CardHolderNameInput extends StatelessWidget {
  const CardHolderNameInput({
    super.key,
    required this.cardholderNameController,
  });

  final TextEditingController cardholderNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: cardholderNameController,
      hintText: 'FULL NAME',
      floatingText: 'CARDHOLDER NAME',
      showErrorBorder: true,
      showErrorMessage: false,
      floatingStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textGreyColor,
      ),
      inputStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textWhite80Color,
      ),
      hintStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.textGreyColor,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: FormValidator.cardNameValidator,
    );
  }
}

class CardHandlerDropdown extends ConsumerWidget {
  final ValueNotifier<CardProvider> cardProviderController;

  const CardHandlerDropdown({
    super.key,
    required this.cardProviderController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 70,
        child: CustomDropdownField<CardProvider>.sheet(
          controller: cardProviderController,
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          height: 25,
          displayFieldColor: Colors.transparent,
          selectedItemBuilder: (item) => Image.asset(
            item.icon,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          itemsSheet: CustomDropdownSheet(
            items: CardProvider.values,
            bottomSheetTitle: 'Card Providers',
            itemBuilder: (_, item) => DropdownSheetItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Provider Name
                  CustomText.body(
                    item.name.capitalize,
                    color: AppColors.textWhite80Color,
                  ),

                  // Provider Icon
                  Image.asset(
                    item.icon,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
