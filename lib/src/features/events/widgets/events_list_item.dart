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

class EventsListItem extends ConsumerWidget {
  final EventModel event;

  const EventsListItem({
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
      child: ClipRRect(
        borderRadius: Corners.rounded9,
        child: SizedBox(
          height: 210,
          child: Stack(
            children: [
              // Event Poster
              Positioned.fill(
                child: CustomNetworkImage(
                  fit: BoxFit.cover,
                  borderRadius: Corners.none,
                  imageUrl: event.posterUrl,
                ),
              ),
      
              // Details
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  color: AppColors.barrierColor,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date
                      Row(
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
      
                      // Full Name
                      CustomText(
                        event.name,
                        maxLines: 2,
                        fontSize: 18,
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
