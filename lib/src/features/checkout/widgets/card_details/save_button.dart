import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Providers
import '../../providers/checkout_provider.codegen.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAdded = ref.watch(
      editedCardDetailsProvider.select((value) => value != null),
    );
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        final card = ref.watch(editedCardDetailsProvider);
        ref.read(savedCardDetailsProvider.notifier).state = card;
        ref.invalidate(editedCardDetailsProvider);
        AppRouter.pop();
      },
      disabled: !cardAdded,
      gradient: AppColors.buttonGradientPrimary,
      child: const Center(
        child: Text(
          'SAVE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 0.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
