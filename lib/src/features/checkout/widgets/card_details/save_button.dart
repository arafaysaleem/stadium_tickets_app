import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Providers
import '../../providers/checkout_provider.dart';

class SaveButton extends ConsumerWidget {
  final VoidCallback onSave;

  const SaveButton({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAdded = ref.watch(
      cardDetailsProvider.select((value) => value != null),
    );
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: onSave,
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
