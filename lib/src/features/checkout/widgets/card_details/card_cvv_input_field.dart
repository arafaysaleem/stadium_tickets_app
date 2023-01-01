import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

class CardCvvInputField extends StatelessWidget {
  const CardCvvInputField({
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
