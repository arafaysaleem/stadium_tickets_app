import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Providers
import '../providers/category_snacks_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SelectSnacksButton extends ConsumerWidget {
  const SelectSnacksButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snacks = ref.watch(
      categorySnacksProvider.select(
        (value) =>
            value.values.fold(0, (prev, element) => prev + element.length),
      ),
    );
    final confirmedSnacks = ref.watch(
      confirmedCategorySnacksProvider.select(
        (value) =>
            value.values.fold(0, (prev, element) => prev + element.length),
      ),
    );
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        ref.read(confirmedCategorySnacksProvider.notifier).state = {
          ...ref.read(categorySnacksProvider)
        };
        AppRouter.pop();
      },
      disabled: snacks == 0 && confirmedSnacks == 0,
      gradient: AppColors.buttonGradientPrimary,
      child: const Center(
        child: Text(
          'Select Snacks',
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
