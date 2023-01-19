import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/booking_summary_provider.codegen.dart';

// Helpers
import '../../../../config/config.dart';
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
    required BuildContext context,
    required String? email,
    required String? contact,
    required GlobalKey<FormState> formKey,
  }) {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus(); // Close keyboard
    formKey.currentState!.save();
    ref.read(buyerEmailProvider.notifier).state = email;
    ref.read(buyerContactProvider.notifier).state = contact;
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyerEmail = ref.watch(buyerEmailProvider);
    final buyerContact = ref.watch(buyerContactProvider);
    final emailController = useTextEditingController(text: buyerEmail);
    final contactController = useTextEditingController(text: buyerContact);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollableBottomSheet(
          snapSizes: const [1],
          initialSheetSize: 1,
          minSheetSize: 0.7,
          titleText: 'Buyer Details',
          leading: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus(); // Close keyboard
              AppRouter.pop();
            },
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
              context: context,
              formKey: formKey,
              ref: ref,
              email: emailController.text,
              contact: contactController.text,
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
              child: Column(
                children: [
                  // Email input
                  CustomTextField(
                    controller: emailController,
                    autofocus: true,
                    floatingText: 'Buyer Email',
                    floatingStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textGreyColor,
                    ),
                    hintText: "Type the ticket booker's email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: FormValidator.emailValidator,
                  ),

                  Insets.gapH15,

                  // Contact Input
                  CustomTextField(
                    controller: contactController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    floatingText: 'Buyer Contact',
                    floatingStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textGreyColor,
                    ),
                    hintText: "Type the ticket booker's contact",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: FormValidator.contactValidator,
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            Config.countryCode,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textLightGreyColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: VerticalDivider(
                              thickness: 1.1,
                              color: AppColors.textLightGreyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
