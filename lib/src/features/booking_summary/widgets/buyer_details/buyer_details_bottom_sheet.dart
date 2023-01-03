import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/booking_summary_provider.codegen.dart';

// Helpers
import '../../../../helpers/form_validator.dart';
import '../../../../helpers/constants/constants.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class BuyerDetailsBottomSheet extends HookConsumerWidget {
  const BuyerDetailsBottomSheet({
    super.key,
  });

  void _onSaveTap({
    required WidgetRef ref,
    required String? email,
    required GlobalKey<FormState> formKey,
  }) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    ref.read(buyerEmailProvider.notifier).state = email;
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyerEmail = ref.watch(buyerEmailProvider);
    final emailController = useTextEditingController(text: buyerEmail);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    return SafeArea(
      child: CustomScrollableBottomSheet(
        snapSizes: const [1],
        initialSheetSize: 1,
        minSheetSize: 0.7,
        titleText: 'Buyer Details',
        leading: InkWell(
          onTap: AppRouter.pop,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CustomText.body(
              'Cancel',
              color: AppColors.textGreyColor,
            ),
          ),
        ),
        trailing: CustomTextButton.gradient(
          width: 60,
          height: 30,
          gradient: AppColors.buttonGradientPrimary,
          onPressed: () => _onSaveTap(
            formKey: formKey,
            ref: ref,
            email: emailController.text,
          ),
          child: Center(
            child: CustomText.subtitle(
              'Apply',
              color: Colors.white,
            ),
          ),
        ),
        builder: (_, __) => Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextField(
              controller: emailController,
              floatingText: 'Buyer Email',
              floatingStyle: const TextStyle(
                fontSize: 15,
                color: AppColors.textGreyColor,
              ),
              hintText: "Type the ticket booker's email",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: FormValidator.emailValidator,
            ),
          ),
        ),
      ),
    );
  }
}
