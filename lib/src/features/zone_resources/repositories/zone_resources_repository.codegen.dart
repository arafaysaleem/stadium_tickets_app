import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../enums/resource_type_enum.dart';
import '../enums/zone_resources_endpoint_enum.dart';
import '../models/zone_resource_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'zone_resources_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
ZoneResourcesRepository zoneResourcesRepository(
  ZoneResourcesRepositoryRef ref,
) {
  final _apiService = ref.watch(apiServiceProvider);
  // return ZoneResourcesRepository(apiService: _apiService);
  return MockZoneResourcesRepository(apiService: _apiService);
}

class ZoneResourcesRepository {
  final ApiService _apiService;

  ZoneResourcesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ZoneResourceModel>> fetchAllZoneResources({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<ZoneResourceModel>(
      endpoint: ZoneResourcesEndpoint.BASE.route(),
      queryParams: queryParameters,
      converter: ZoneResourceModel.fromJson,
    );
  }
}

class MockZoneResourcesRepository implements ZoneResourcesRepository {
  @override
  final ApiService _apiService;

  MockZoneResourcesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<ZoneResourceModel>> fetchAllZoneResources({
    JSON? queryParameters,
  }) {
    return Future.delayed(
      2.seconds,
      () => <ZoneResourceModel>[
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
      ],
    );
  }
}
