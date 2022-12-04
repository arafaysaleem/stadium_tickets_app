import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/extensions/datetime_extension.dart';

// Router
import '../../../config/routing/app_router.dart';
import '../../../config/routing/routes.dart';

// Providers
import '../providers/events_provider.codegen.dart';

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
          height: 220,
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
                  height: 107,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.97),
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      stops: const [0.35, 0.67, 1],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Datetime
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Date
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
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Insets.gapH10,

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
