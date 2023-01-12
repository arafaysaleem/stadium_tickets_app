import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../models/parking_floor_model.codegen.dart';
import '../models/space_model.codegen.dart';

// Helpers
import '../enums/parking_endpoint_enum.dart';
import '../../../helpers/typedefs.dart';

part 'parking_repository.codegen.g.dart';

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
ParkingRepository parkingRepository(ParkingRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return MockParkingRepository(apiService: _apiService);
  // return ParkingRepository(apiService: _apiService);
}

class ParkingRepository {
  final ApiService _apiService;

  ParkingRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<ParkingFloorModel>> fetchAllParking({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<ParkingFloorModel>(
      endpoint: ParkingEndpoint.BASE.route(),
      queryParams: queryParameters,
      converter: ParkingFloorModel.fromJson,
    );
  }

  Future<List<SpaceModel>> fetchAllParkingFloorSpaces({
    required int pFloorId,
    required int eventId,
  }) async {
    return _apiService.getCollectionData<SpaceModel>(
      endpoint: ParkingEndpoint.SPACES.route(
        id: pFloorId,
        eventId: eventId,
      ),
      converter: SpaceModel.fromJson,
    );
  }
}

class MockParkingRepository implements ParkingRepository {
  @override
  final ApiService _apiService;

  static const mockSpaces = <int, List<SpaceModel>>{
    1: [
      SpaceModel(spaceRow: 'A', spaceNumber: 1),
      SpaceModel(spaceRow: 'B', spaceNumber: 1),
      SpaceModel(spaceRow: 'D', spaceNumber: 1),
      SpaceModel(spaceRow: 'E', spaceNumber: 0),
      SpaceModel(spaceRow: 'F', spaceNumber: 0),
    ],
    2: [
      SpaceModel(spaceRow: 'A', spaceNumber: 1),
      SpaceModel(spaceRow: 'B', spaceNumber: 1),
      SpaceModel(spaceRow: 'D', spaceNumber: 1),
      SpaceModel(spaceRow: 'E', spaceNumber: 0),
      SpaceModel(spaceRow: 'F', spaceNumber: 0),
    ],
    11: [
      SpaceModel(spaceRow: 'A', spaceNumber: 1),
    ],
  };

  MockParkingRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<ParkingFloorModel>> fetchAllParking({JSON? queryParameters}) {
    return Future.delayed(
      2.seconds,
      () => <ParkingFloorModel>[
        ParkingFloorModel.fromJson(<String, dynamic>{
          'p_floor_id': 11,
          'floor_number': 1,
          'spaces_per_row': 17,
          'num_of_rows': 20,
          'price': 30,
          'missing': <SpaceModel>[],
          'blocked': <SpaceModel>[],
        }),
        ParkingFloorModel.fromJson(<String, dynamic>{
          'p_floor_id': 2,
          'floor_number': 2,
          'spaces_per_row': 13,
          'num_of_rows': 7,
          'price': 30,
          'missing': <SpaceModel>[],
          'blocked': <SpaceModel>[],
        }),
        ParkingFloorModel.fromJson(<String, dynamic>{
          'p_floor_id': 1,
          'floor_number': 3,
          'spaces_per_row': 14,
          'num_of_rows': 17,
          'price': 30,
          'missing': <SpaceModel>[],
          'blocked': <SpaceModel>[],
        }),
      ],
    );
  }

  @override
  Future<List<SpaceModel>> fetchAllParkingFloorSpaces({
    required int pFloorId,
    required int eventId,
  }) {
    return Future.delayed(2.seconds, () => mockSpaces[pFloorId]!);
  }
}
