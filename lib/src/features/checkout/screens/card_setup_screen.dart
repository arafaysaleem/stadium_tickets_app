import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Routing
import '../../../config/routing/routing.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/card_details_model.codegen.dart';

// Providers
import '../providers/checkout_provider.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import '../widgets/card_details/card_template.dart';
import '../widgets/card_details/save_button.dart';

class CardSetupScreen extends HookConsumerWidget {
  const CardSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedCardDetails = ref.watch(cardDetailsProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final cardholderNameController = useTextEditingController(
      text: savedCardDetails?.cardHolderName,
    );
    final cardCVVController = useTextEditingController(
      text: savedCardDetails?.cvv.toString(),
    );
    final cardNumberController = useTextEditingController(
      text: savedCardDetails?.cardNumber.toString(),
    );
    final cardExpiryController = useTextEditingController(
      text: savedCardDetails?.expiry,
    );

    void onSave() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final card = CardDetailsModel(
          cardHolderName: cardholderNameController.text,
          cardNumber: int.parse(cardNumberController.text),
          cvv: int.parse(cardCVVController.text),
          expiry: cardExpiryController.text,
        );
        ref.read(cardDetailsProvider.notifier).state = card;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: ScrollableColumn(
                children: [
                  Insets.gapH10,

                  // Back icon and title
                  Row(
                    children: const [
                      CustomBackIcon(
                        onTap: AppRouter.pop,
                      ),

                      // Title
                      Expanded(
                        child: CustomText(
                          'Add New Card',
                          fontSize: 22,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Insets.gapW30,
                    ],
                  ),

                  Insets.gapH20,

                  // Card Template
                  CardTemplate(
                    cardholderNameController: cardholderNameController,
                    cardCVVController: cardCVVController,
                    cardNumberController: cardNumberController,
                    cardExpiryController: cardExpiryController,
                  ),

                  Insets.gapH20,

                  // Current Input Message
                  CustomText.title(
                    'Enter your card details',
                    color: AppColors.textBlackColor,
                  ),

                  Insets.expand,

                  // Save Button
                  SaveButton(onSave: onSave),

                  Insets.bottomInsetsLow,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
