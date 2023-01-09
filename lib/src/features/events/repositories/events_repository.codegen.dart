import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../enums/event_type_enum.dart';
import '../enums/events_endpoint_enum.dart';
import '../models/event_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'events_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
EventsRepository eventsRepository(EventsRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  // return MockEventsRepository(apiService: _apiService);
  return EventsRepository(apiService: _apiService);
}

class EventsRepository {
  final ApiService _apiService;

  EventsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<EventModel>> fetchAllEvents({JSON? queryParameters}) async {
    return _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.BASE.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }
}

class MockEventsRepository implements EventsRepository {
  @override
  final ApiService _apiService;

  MockEventsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<EventModel>> fetchAllEvents({JSON? queryParameters}) {
    return Future.delayed(
      2.seconds,
      () => <EventModel>[
        EventModel(
          eventId: 1,
          name: 'NBA 2022 Finale - Lakers vs Warriors',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://wallpapercave.com/wp/wp1713760.jpg',
          eventType: EventType.OPEN,
        ),
        EventModel(
          eventId: 2,
          name: 'ESL Champions Finale',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl:
              'https://img.mensxp.com/media/content/2019/Apr/the-esl-one-dota-2-tournament-in-mumbai-was-crazy-1200x900-1556079193.jpg',
          eventType: EventType.OPEN,
        ),
        EventModel(
          eventId: 3,
          name: 'EDM Rave Night',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl:
              'https://img.freepik.com/free-vector/music-event-poster-template-with-colorful-shapes_1361-1591.jpg',
          eventType: EventType.OPEN,
        ),
        EventModel(
          eventId: 4,
          name: 'La Liga Semi - PSG vs Man City',
          date: DateTime.now(),
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
          posterUrl: 'https://i.ytimg.com/vi/7J4315BBr2E/maxresdefault.jpg',
          eventType: EventType.OPEN,
        )
      ],
    );
  }
}
