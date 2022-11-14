import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:time/time.dart';

// Models
import '../enums/event_type_enum.dart';
import '../models/event_model.codegen.dart';

// Providers
import '../providers/filter_providers.codegen.dart';

// Widgets
import '../../../global/widgets/async_value_widget.dart';
import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/error_response_handler.dart';
import 'events_grid_item.dart';

class EventsGridList extends ConsumerWidget {
  const EventsGridList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<EventModel>>(
      value: AsyncData(<EventModel>[
        EventModel(
          eventId: 1,
          name: 'Pak vs England',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://thumbs.dreamstime.com/b/cricket-match-england-vs-pakistan-country-flag-shields-cricket-match-england-vs-pakistan-country-flag-139688792.jpg',
          eventType: EventType.OPEN,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        EventModel(
          eventId: 2,
          name: 'Pak vs England',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://thumbs.dreamstime.com/b/cricket-match-england-vs-pakistan-country-flag-shields-cricket-match-england-vs-pakistan-country-flag-139688792.jpg',
          eventType: EventType.OPEN,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        EventModel(
          eventId: 3,
          name: 'Pak vs England',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://thumbs.dreamstime.com/b/cricket-match-england-vs-pakistan-country-flag-shields-cricket-match-england-vs-pakistan-country-flag-139688792.jpg',
          eventType: EventType.OPEN,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        EventModel(
          eventId: 4,
          name: 'Pak vs England',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://thumbs.dreamstime.com/b/cricket-match-england-vs-pakistan-country-flag-shields-cricket-match-england-vs-pakistan-country-flag-139688792.jpg',
          eventType: EventType.OPEN,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ]),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 70),
        child: CustomCircularLoader(),
      ),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () {},
        stackTrace: st,
      ),
      emptyOrNull: () => const EmptyStateWidget(
        height: 395,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        title: 'No Events found',
        subtitle: 'Try changing the search term or check back later',
      ),
      data: (filteredEvents) {
        final events = ref.watch(searchedEventsProvider(filteredEvents));
        return GridView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.zero,
          itemCount: events.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 4 / 4.1,
          ),
          itemBuilder: (_, i) => EventsGridItem(
            event: events[i],
          ),
        );
      },
    );
  }
}
