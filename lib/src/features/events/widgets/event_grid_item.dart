import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/extensions/datetime_extension.dart';

// Models
import '../models/event_model.codegen.dart';

// Widgets
import '../../../global/widgets/custom_network_image.dart';

class EventGridItem extends ConsumerWidget {
  final EventModel event;

  const EventGridItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded9,
          color: Colors.white,
          boxShadow: Shadows.elevated,
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Event Poster
            CustomNetworkImage(
              height: 58,
              width: 58,
              shape: BoxShape.circle,
              imageUrl: event.posterUrl,
            ),

            Insets.gapH10,

            // Full Name
            Text(
              event.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: AppTypography.primary.body14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Insets.gapH3,

            // Date
            Text(
              event.date.toDateString(),
              textAlign: TextAlign.center,
              style: AppTypography.primary.body14.copyWith(
                color: AppColors.textLightGreyColor,
              ),
            ),

            Insets.expand,

            // Times
            Text(
              '${event.startTime}-${event.endTime}',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.primary.subtitle13.copyWith(
                color: AppColors.textLightGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
