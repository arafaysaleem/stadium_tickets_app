import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Formatters
import '../../../../global/formatters/formatters.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/form_validator.dart';

class CardExpiryInputField extends HookWidget {
  const CardExpiryInputField({
    super.key,
    required this.cardExpiryController,
  });

  final TextEditingController cardExpiryController;
  static final _expiryFormatter = CardExpiryInputFormatter();

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        final formattedExpiry = _expiryFormatter.formatEditUpdate(
          TextEditingValue.empty,
          cardExpiryController.value,
        );
        cardExpiryController.value = formattedExpiry;
        return null;
      },
      const [],
    );
    return CustomTextField(
      controller: cardExpiryController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _expiryFormatter
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
