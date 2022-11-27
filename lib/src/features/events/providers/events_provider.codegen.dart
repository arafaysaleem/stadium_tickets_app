import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Enums
import '../enums/event_type_enum.dart';

// Models
import '../models/event_model.codegen.dart';

part 'events_provider.codegen.g.dart';

final currentEventProvider = StateProvider<EventModel?>((_) => null);

final mockEventsList = <EventModel>[
  EventModel(
    eventId: 1,
    name: 'NBA 2022 Finale - Lakers vs Warriors',
    date: DateTime.now(),
    startTime: TimeOfDay.now(),
    endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
    posterUrl: 'https://wallpapercave.com/wp/wp1713760.jpg',
    eventType: EventType.OPEN,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  EventModel(
    eventId: 4,
    name: 'La Liga Semi - PSG vs Man City',
    date: DateTime.now(),
    startTime: TimeOfDay.now(),
    endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
    posterUrl: 'https://i.ytimg.com/vi/7J4315BBr2E/maxresdefault.jpg',
    eventType: EventType.OPEN,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];

@riverpod
Future<List<EventModel>> eventsFuture(EventsFutureRef ref) async {
  return Future.delayed(2.seconds, () => mockEventsList);
}
