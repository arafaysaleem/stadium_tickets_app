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

  const ZoneNumberBox({
    super.key,
    required this.zone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (zone == null) return Insets.shrink;
    final isSelected = ref.watch(
      currentZoneProvider.select((value) => value == zone),
    );
    final size = isSelected ? 26.0 : 24.0;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          ref.read(currentZoneProvider.notifier).state = zone;
        } else {
          ref.invalidate(currentZoneProvider);
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
            '${zone!.number}',
            color: AppColors.textWhite80Color,
          ),
        ),
      ),
    );
  }
}
