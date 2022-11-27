import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

final resourceTypeProvider = StateProvider.autoDispose((ref) => 0);

class ResourceTypeSlider extends ConsumerWidget {
  const ResourceTypeSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSegmentValue = ref.watch(resourceTypeProvider);
    return CupertinoSlidingSegmentedControl(
      children: {
        0: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Images',
            style: TextStyle(
              fontSize: 13,
              color: selectedSegmentValue == 0
                  ? AppColors.textWhite80Color
                  : AppColors.primaryColor,
            ),
          ),
        ),
        1: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Videos',
            style: TextStyle(
              fontSize: 13,
              color: selectedSegmentValue == 1
                  ? AppColors.textWhite80Color
                  : AppColors.primaryColor,
            ),
          ),
        ),
      },
      padding: const EdgeInsets.all(6),
      thumbColor: AppColors.primaryColor,
      backgroundColor: AppColors.surfaceColor,
      groupValue: selectedSegmentValue,
      onValueChanged: (int? newValue) {
        if (newValue != null) {
          ref.read(resourceTypeProvider.notifier).state = newValue;
        }
      },
    );
  }
}
