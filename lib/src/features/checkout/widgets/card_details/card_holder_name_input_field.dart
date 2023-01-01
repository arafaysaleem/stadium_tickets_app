import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Formatters
import '../../../../global/formatters/formatters.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

class CardNumberInputField extends StatelessWidget {
  const CardNumberInputField({
    super.key,
    required this.cardNumberController,
  });

  final TextEditingController cardNumberController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
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
    );
  }
}
