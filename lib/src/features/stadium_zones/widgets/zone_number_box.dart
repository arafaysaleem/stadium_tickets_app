import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Providers
import '../providers/zones_provider.dart';

// Widgets
import '../../../global/widgets/custom_text.dart';

class ZoneNumberBox extends ConsumerWidget {
  final int number;

  const ZoneNumberBox({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentZoneNoProvider.select((value) => value == number),
    );
    final size = isSelected ? 26.0 : 24.0;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          ref.read(currentZoneNoProvider.notifier).state = number;
        } else {
          ref.read(currentZoneNoProvider.notifier).state = null;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded4,
          color: isSelected
              ? AppColors.primaryColor
              : const Color.fromARGB(255, 126, 127, 135),
        ),
        margin: isSelected ? const EdgeInsets.all(5) : const EdgeInsets.all(6),
        height: size,
        width: size,
        child: Center(
          child: CustomText.label(
            '$number',
            color: AppColors.textWhite80Color,
          ),
        ),
      ),
    );
  }
}
