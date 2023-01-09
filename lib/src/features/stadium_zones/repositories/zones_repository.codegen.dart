import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../enums/zones_endpoint_enum.dart';
import '../models/zone_model.codegen.dart';
import '../models/zone_seating_model.codegen.dart';

// Helpers
import '../../../helpers/typedefs.dart';

part 'zones_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
ZonesRepository zonesRepository(ZonesRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  // return MockZonesRepository(apiService: _apiService);
  return ZonesRepository(apiService: _apiService);
}

class ZonesRepository {
  final ApiService _apiService;

  ZonesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ZoneModel>> fetchAllZones({JSON? queryParameters}) async {
    return _apiService.getCollectionData<ZoneModel>(
      endpoint: ZonesEndpoint.BASE.route(),
      queryParams: queryParameters,
      converter: ZoneModel.fromJson,
    );
  }

  Future<ZoneSeatingModel> fetchAllZoneSeats({required int zoneId}) async {
    return _apiService.getDocumentData<ZoneSeatingModel>(
      endpoint: ZonesEndpoint.SEATS.route(id: zoneId),
      converter: ZoneSeatingModel.fromJson,
    );
  }
}

class MockZonesRepository implements ZonesRepository {
  @override
  final ApiService _apiService;

  MockZonesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<ZoneModel>> fetchAllZones({JSON? queryParameters}) {
    return Future.delayed(
      2.seconds,
      () => <ZoneModel>[
        ZoneModel.fromJson(<String, dynamic>{
          'zone_id': 11,
          'name': 'WEST',
          'number': 5,
          'seats_per_row': 17,
          'num_of_rows': 20,
          'color_hex_code': '#FDDF00',
          'z_type_id': 1,
          'type': {'z_type_id': 1, 'type': 'vip', 'price': 70}
        }),
        ZoneModel.fromJson(<String, dynamic>{
          'zone_id': 2,
          'name': 'SOUTH DECK',
          'number': 9,
          'seats_per_row': 13,
          'num_of_rows': 7,
          'color_hex_code': '#FDDF00',
          'z_type_id': 2,
          'type': {'z_type_id': 2, 'type': 'general', 'price': 10}
        }),
        ZoneModel.fromJson(<String, dynamic>{
          'zone_id': 1,
          'name': 'NORTH',
          'number': 6,
          'seats_per_row': 14,
          'num_of_rows': 17,
          'color_hex_code': '#FDDF00',
          'z_type_id': 3,
          'type': {'z_type_id': 3, 'type': 'premium', 'price': 40}
        }),
      ],
    );
  }

  @override
  Future<ZoneSeatingModel> fetchAllZoneSeats({required int zoneId}) {
    return Future.delayed(
      2.seconds,
      () => const ZoneSeatingModel(
        missing: [],
        blocked: [],
        booked: [],
      ),
    );
  }
}
