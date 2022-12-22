import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/zone_model.codegen.dart';

// Providers
import '../providers/zones_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class ZoneNumberBox extends ConsumerWidget {
  final ZoneModel? zone;
  final int number;

  const ZoneNumberBox({
    super.key,
    required this.zone,
    required this.number,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      currentZoneProvider.select((value) => value == zone),
    );
    final size = isSelected ? 26.0 : 24.0;
    return InkWell(
      onTap: () {
        if (zone == null) return;
        if (!isSelected) {
          ref.read(currentZoneProvider.notifier).state = zone;
        } else {
          ref.invalidate(currentZoneProvider);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.rounded4,
          color: zone == null
              ? const Color.fromARGB(255, 60, 60, 60)
              : isSelected
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
