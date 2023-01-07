import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../enums/event_type_enum.dart';
import '../models/event_model.codegen.dart';

// Providers
import 'events_provider.codegen.dart';

part 'filter_providers.codegen.g.dart';

final searchFilterProvider = StateProvider.autoDispose<String>((ref) => '');
final eventDateFilterProvider = StateProvider<DateTime?>((ref) => null);

final filtersProvider = Provider<JSON>(
  (ref) {
    final eventDateFilter = ref.watch(eventDateFilterProvider.notifier).state;

    final filters = EventModel.toCustomJson(
      date: eventDateFilter,
      eventType: EventType.OPEN,
    );

    return filters;
  },
);

@riverpod
Future<List<EventModel>> filteredEvents(FilteredEventsRef ref) {
  final queryParams = ref.watch(filtersProvider);
  return ref.watch(eventsControllerProvider).getAllEvents(queryParams);
}

/// A provider used to access list of searched events
@riverpod
List<EventModel> searchedEvents(
  SearchedEventsRef ref,
  List<EventModel> filteredEvents,
) {
  final _searchTerm = ref.watch(searchFilterProvider).toLowerCase();
  if (_searchTerm.isEmpty) {
    return filteredEvents;
  }
  return filteredEvents
      .where((event) => event.name.toLowerCase().contains(_searchTerm))
      .toList();
}
