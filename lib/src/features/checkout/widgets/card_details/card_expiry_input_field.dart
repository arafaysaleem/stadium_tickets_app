import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Formatters
import '../../../../global/formatters/formatters.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

class CardExpiryInputField extends StatelessWidget {
  const CardExpiryInputField({
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
