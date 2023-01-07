import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Enums
import '../../../helpers/typedefs.dart';

// Models
import '../models/event_model.codegen.dart';

// Repositories
import '../repositories/events_repository.codegen.dart';

part 'events_provider.codegen.g.dart';

final currentEventProvider = StateProvider<EventModel?>((_) => null);

@riverpod
Future<List<EventModel>> eventsFuture(EventsFutureRef ref) async {
  return ref.watch(eventsProvider).getAllEvents();
}

/// A provider used to access instance of this service
@riverpod
EventsProvider events(EventsRef ref) {
  return EventsProvider(ref.watch(eventsRepositoryProvider));
}

class EventsProvider {
  final EventsRepository _eventsRepository;

  EventsProvider(this._eventsRepository);

  Future<List<EventModel>> getAllEvents([JSON? queryParams]) async {
    return _eventsRepository.fetchAllEvents(queryParameters: queryParams);
  }
}
