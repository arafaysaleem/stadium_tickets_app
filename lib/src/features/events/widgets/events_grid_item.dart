import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/extensions/datetime_extension.dart';

// Router
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Providers
import '../providers/events_provider.dart';

// Models
import '../models/event_model.codegen.dart';

// Widgets
import '../../../global/widgets/custom_text.dart';
import '../../../global/widgets/custom_network_image.dart';

class EventsGridItem extends ConsumerWidget {
  final EventModel event;

  const EventsGridItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: () {
        ref.read(currentEventProvider.notifier).state = event;
        AppRouter.pushNamed(Routes.StadiumZonesScreenRoute);
      },
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          borderRadius: Corners.rounded9,
          color: AppColors.surfaceColor,
        ),
        child: Column(
          children: [
            // Event Poster
            CustomNetworkImage(
              height: 135,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
              imageUrl: event.posterUrl,
            ),

            Insets.gapH5,

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 18,
                              ),
                              Insets.gapW(7),
                              CustomText(
                                event.date.toDateString('d MMM, y'),
                                textAlign: TextAlign.center,
                                color: AppColors.textGreyColor,
                                fontSize: 12,
                              ),
                            ],
                          ),

                          // Times
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 18,
                              ),
                              Insets.gapW(7),
                              CustomText(
                                '${event.startTime.format(context)} - ${event.endTime.format(context)}',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                color: AppColors.textGreyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Full Name
                    CustomText(
                      event.name,
                      maxLines: 2,
                      fontSize: 18,
                      overflow: TextOverflow.fade,
                      fontWeight: FontWeight.bold,
                    ),

                    Insets.gapH3,
                  ],
                ),
              ),
            ),

            Insets.gapH10,
          ],
        ),
      ),
    );
  }
}
