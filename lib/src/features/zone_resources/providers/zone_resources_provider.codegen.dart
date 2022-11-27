import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Enums
import '../enums/resource_type_enum.dart';

// Models
import '../models/zone_resource_model.codegen.dart';

part 'zone_resources_provider.codegen.g.dart';

final mockZoneResourcesList = <ZoneResourceModel>[
  ZoneResourceModel(
    resourceId: 1,
    zoneId: 2,
    resourceUrl:
        'https://img.freepik.com/free-vector/music-event-banner-template-with-photo_52683-12627.jpg',
    type: ResourceType.IMAGE,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  ZoneResourceModel(
    resourceId: 2,
    zoneId: 2,
    resourceUrl:
        'https://img.freepik.com/free-vector/music-event-banner-template-with-photo_52683-12627.jpg',
    type: ResourceType.IMAGE,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  ZoneResourceModel(
    resourceId: 3,
    zoneId: 2,
    resourceUrl:
        'https://img.freepik.com/free-vector/music-event-poster-template-with-colorful-shapes_1361-1591.jpg',
    type: ResourceType.IMAGE,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  ZoneResourceModel(
    resourceId: 4,
    zoneId: 2,
    resourceUrl:
        'https://img.freepik.com/free-vector/music-event-poster-template-with-abstract-shapes_1361-1316.jpg',
    type: ResourceType.VIDEO,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];

@riverpod
Future<List<ZoneResourceModel>> zoneResourcesFuture(ZoneResourcesFutureRef ref) async {
  return Future.delayed(2.seconds, () => mockZoneResourcesList);
}
