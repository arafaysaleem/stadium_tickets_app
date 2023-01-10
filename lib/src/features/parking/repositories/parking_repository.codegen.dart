import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Models
import '../models/parking_floor_model.codegen.dart';
import '../models/parking_floor_spaces_model.codegen.dart';
import '../models/space_model.codegen.dart';

// Helpers
import '../enums/parking_endpoint_enum.dart';
import '../../../helpers/typedefs.dart';

part 'parking_repository.codegen.g.dart';

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
ParkingRepository parkingRepository(ParkingRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  // return MockParkingRepository(apiService: _apiService);
  return ParkingRepository(apiService: _apiService);
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

  Future<ParkingFloorSpacesModel> fetchAllParkingFloorSpaces({
    required int pFloorId,
  }) async {
    return _apiService.getDocumentData<ParkingFloorSpacesModel>(
      endpoint: ParkingEndpoint.SPACES.route(id: pFloorId),
      converter: ParkingFloorSpacesModel.fromJson,
    );
  }
}

class MockParkingRepository implements ParkingRepository {
  @override
  final ApiService _apiService;

  static const mockSpaces = <int, ParkingFloorSpacesModel>{
    1: ParkingFloorSpacesModel(
      missing: [
        SpaceModel(spaceRow: 'A', spaceNumber: 2),
        SpaceModel(spaceRow: 'B', spaceNumber: 2),
        SpaceModel(spaceRow: 'C', spaceNumber: 2),
        SpaceModel(spaceRow: 'D', spaceNumber: 2),
        SpaceModel(spaceRow: 'E', spaceNumber: 2),
        SpaceModel(spaceRow: 'F', spaceNumber: 2),
        SpaceModel(spaceRow: 'G', spaceNumber: 2),
        SpaceModel(spaceRow: 'H', spaceNumber: 2),
        SpaceModel(spaceRow: 'I', spaceNumber: 2),
        SpaceModel(spaceRow: 'J', spaceNumber: 2),
        SpaceModel(spaceRow: 'K', spaceNumber: 2),
        SpaceModel(spaceRow: 'L', spaceNumber: 2),
        SpaceModel(spaceRow: 'M', spaceNumber: 2),
      ],
      blocked: [
        SpaceModel(spaceRow: 'C', spaceNumber: 1),
        SpaceModel(spaceRow: 'D', spaceNumber: 0),
        SpaceModel(spaceRow: 'A', spaceNumber: 2),
      ],
      booked: [
        SpaceModel(spaceRow: 'A', spaceNumber: 1),
        SpaceModel(spaceRow: 'B', spaceNumber: 1),
        SpaceModel(spaceRow: 'D', spaceNumber: 1),
        SpaceModel(spaceRow: 'E', spaceNumber: 0),
        SpaceModel(spaceRow: 'F', spaceNumber: 0),
      ],
    ),
    2: ParkingFloorSpacesModel(missing: [], blocked: [], booked: []),
    11: ParkingFloorSpacesModel(
      missing: [
        SpaceModel(spaceRow: 'A', spaceNumber: 2),
        SpaceModel(spaceRow: 'B', spaceNumber: 2),
        SpaceModel(spaceRow: 'C', spaceNumber: 2),
        SpaceModel(spaceRow: 'D', spaceNumber: 2),
        SpaceModel(spaceRow: 'E', spaceNumber: 2),
        SpaceModel(spaceRow: 'F', spaceNumber: 2),
        SpaceModel(spaceRow: 'G', spaceNumber: 2),
        SpaceModel(spaceRow: 'H', spaceNumber: 2),
        SpaceModel(spaceRow: 'I', spaceNumber: 2),
        SpaceModel(spaceRow: 'J', spaceNumber: 2),
        SpaceModel(spaceRow: 'K', spaceNumber: 2),
        SpaceModel(spaceRow: 'L', spaceNumber: 2),
        SpaceModel(spaceRow: 'M', spaceNumber: 2),
      ],
      blocked: [
        SpaceModel(spaceRow: 'C', spaceNumber: 1),
        SpaceModel(spaceRow: 'D', spaceNumber: 0),
        SpaceModel(spaceRow: 'A', spaceNumber: 2),
      ],
      booked: [
        SpaceModel(spaceRow: 'A', spaceNumber: 1),
        SpaceModel(spaceRow: 'B', spaceNumber: 1),
        SpaceModel(spaceRow: 'D', spaceNumber: 1),
        SpaceModel(spaceRow: 'E', spaceNumber: 0),
        SpaceModel(spaceRow: 'F', spaceNumber: 0),
      ],
    ),
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
        }),
        ParkingFloorModel.fromJson(<String, dynamic>{
          'p_floor_id': 2,
          'floor_number': 2,
          'spaces_per_row': 13,
          'num_of_rows': 7,
        }),
        ParkingFloorModel.fromJson(<String, dynamic>{
          'p_floor_id': 1,
          'floor_number': 3,
          'spaces_per_row': 14,
          'num_of_rows': 17,
        }),
      ],
    );
  }

  @override
  Future<ParkingFloorSpacesModel> fetchAllParkingFloorSpaces({
    required int pFloorId,
  }) {
    return Future.delayed(2.seconds, () => mockSpaces[pFloorId]!);
  }
}
