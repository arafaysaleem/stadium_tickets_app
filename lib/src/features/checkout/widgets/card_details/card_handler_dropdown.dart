import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';
import '../../../../helpers/extensions/extensions.dart';
import '../../enums/card_provider_enum.dart';

class CardHandlerDropdown extends ConsumerWidget {
  final ValueNotifier<CardProvider> cardProviderController;

  const CardHandlerDropdown({
    super.key,
    required this.cardProviderController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 70,
        child: CustomDropdownField<CardProvider>.sheet(
          controller: cardProviderController,
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          height: 25,
          displayFieldColor: Colors.transparent,
          selectedItemBuilder: (item) => Image.asset(
            item.icon,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          itemsSheet: CustomDropdownSheet(
            items: CardProvider.values,
            bottomSheetTitle: 'Card Providers',
            itemBuilder: (_, item) => DropdownSheetItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Provider Name
                  CustomText.body(
                    item.name.capitalize,
                    color: AppColors.textWhite80Color,
                  ),

                  // Provider Icon
                  Image.asset(
                    item.icon,
                    height: 40,
                    fit: BoxFit.contain,
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
