import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/booking_summary_provider.codegen.dart';

// Models
import '../../models/booking_seat_model.codegen.dart';

// Helpers
import '../../../../helpers/form_validator.dart';
import '../../../../helpers/constants/constants.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

class TicketDetailsBottomSheet extends HookConsumerWidget {
  final int index;
  final BookingSeatModel seatTicket;

  const TicketDetailsBottomSheet({
    super.key,
    required this.index,
    required this.seatTicket,
  });

  void _onSaveTap({
    required WidgetRef ref,
    required String? personName,
    required String? personId,
    required GlobalKey<FormState> formKey,
  }) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    ref.read(seatTicketsProvider.notifier).update(
      (state) {
        state[index] = state[index].copyWith(
          identificationNumber: personId,
          personName: personName,
        );
        return [...state];
      },
    );
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController =
        useTextEditingController(text: seatTicket.personName);
    final idController =
        useTextEditingController(text: seatTicket.identificationNumber);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    return SafeArea(
      child: CustomScrollableBottomSheet(
        snapSizes: const [1],
        initialSheetSize: 1,
        minSheetSize: 0.7,
        titleText: 'Ticket Details',
        leading: GestureDetector(
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
            personName: nameController.text,
            personId: idController.text,
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
                // Person Name
                CustomTextField(
                  controller: nameController,
                  autofocus: true,
                  floatingText: 'Person Name',
                  floatingStyle: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textGreyColor,
                  ),
                  hintText: "Type the ticket designee's name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.nameValidator,
                ),

                Insets.gapH15,

                // Person Id
                CustomTextField(
                  controller: idController,
                  floatingText: 'Person Id',
                  floatingStyle: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textGreyColor,
                  ),
                  hintText: 'X-XXXX-XXXX or XXXXXXXXXXXX',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: FormValidator.idValidator,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
