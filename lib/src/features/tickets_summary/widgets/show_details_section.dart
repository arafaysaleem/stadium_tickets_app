import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';
import '../../../helpers/extensions/extensions.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

// Features
import '../../events/events.dart';
import '../../stadium_zones/stadium_zones.dart';

class ShowDetailsSection extends ConsumerWidget {
  const ShowDetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(currentEventProvider)!;
    final zoneName =
        ref.watch(currentZoneProvider.select((value) => value!.name));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event datetime
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date
              LabeledWidget(
                label: 'Date',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  selectedEvent.date.toDateString('E, d MMMM y'),
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              // Time
              LabeledWidget(
                label: 'Time',
                labelStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGreyColor,
                ),
                child: CustomText(
                  selectedEvent.startTime.format(context),
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Insets.gapH10,

          // Zone
          LabeledWidget(
            label: 'Zone',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              zoneName,
              color: AppColors.textBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
