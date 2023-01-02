import 'package:flutter/material.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

class CardHolderNameInputField extends StatelessWidget {
  const CardHolderNameInputField({
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
