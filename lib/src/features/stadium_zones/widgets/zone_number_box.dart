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
          color:
              isSelected ? AppColors.secondaryColor : const Color(0xFFCCCFDC),
        ),
        margin: isSelected ? const EdgeInsets.all(5) : const EdgeInsets.all(6),
        height: isSelected ? 25 : 22,
        width: isSelected ? 25 : 22,
        child: Center(
          child: CustomText.label(
            '$number',
            color: isSelected
                ? AppColors.textWhite80Color
                : const Color(0xFF585A5F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
