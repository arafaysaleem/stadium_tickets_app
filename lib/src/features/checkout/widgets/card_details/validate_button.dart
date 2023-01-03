import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Providers
import '../../providers/checkout_provider.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class ValidateButton extends ConsumerWidget {
  final VoidCallback onValidate;

  const ValidateButton({
    super.key,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCardAdded = ref.watch(
      editedCardDetailsProvider.select((value) => value != null),
    );
    return AnimatedSwitcher(
      duration: Durations.fast,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: isCardAdded
          ? SizedBox(
              width: 70,
              height: 35,
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.green.shade800,
                ),
              ),
            )
          : CustomTextButton.gradient(
              width: 70,
              height: 35,
              gradient: AppColors.buttonGradientPrimary,
              onPressed: onValidate,
              child: Center(
                child: CustomText.subtitle(
                  'Validate',
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
