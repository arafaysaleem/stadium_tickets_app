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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Zone
          LabeledWidget(
            label: 'Zone',
            labelStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.textGreyColor,
            ),
            child: CustomText(
              zoneName,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
