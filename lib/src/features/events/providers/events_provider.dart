import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:time/time.dart';

// Enums
import '../enums/event_type_enum.dart';

// Models
import '../models/event_model.codegen.dart';

final mockEvent = EventModel(
  eventId: 1,
  name: 'Pak vs England',
  date: DateTime.now(),
  startTime: TimeOfDay.now(),
  endTime: TimeOfDay.fromDateTime(DateTime.now().add(5.hours)),
  posterUrl:
      'https://thumbs.dreamstime.com/b/cricket-match-england-vs-pakistan-country-flag-shields-cricket-match-england-vs-pakistan-country-flag-139688792.jpg',
  eventType: EventType.OPEN,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final currentEventProvider =
    StateProvider.autoDispose<EventModel?>((_) => mockEvent);
