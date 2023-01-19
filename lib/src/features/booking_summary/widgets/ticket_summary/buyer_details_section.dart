import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Providers
import '../../providers/booking_summary_provider.codegen.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';
import '../buyer_details/buyer_details_bottom_sheet.dart';

class BuyerDetailsSection extends ConsumerWidget {
  const BuyerDetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyerEmail = ref.watch(buyerEmailProvider);
    final buyerContact = ref.watch(buyerContactProvider);
    final isDetailAdded = buyerEmail != null && buyerContact != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      color: isDetailAdded ? Colors.white : AppColors.greyOutlineColor,
      child: Row(
        children: [
          // Email & Phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledWidget(
                label: 'Email',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  buyerEmail ?? 'Not added',
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              Insets.gapH10,

              // Phone
              LabeledWidget(
                label: 'Contact',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  buyerContact ?? 'Not added',
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Insets.expand,

          // Add/Edit Details Button
          CustomTextButton.gradient(
            gradient: AppColors.buttonGradientPrimary,
            width: 44,
            height: 27,
            onPressed: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (_) => const BuyerDetailsBottomSheet(),
              );
            },
            child: Center(
              child: CustomText(
                fontSize: 13,
                isDetailAdded ? 'Edit' : 'Add',
              ),
            ),
          )
        ],
      ),
    );
  }
}
