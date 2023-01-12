import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time/time.dart';

// Networking
import '../../../core/core.dart';

// Enums
import '../enums/bookings_endpoint_enum.dart';

// Helpers
import '../../../helpers/constants/app_utils.dart';
import '../../../helpers/typedefs.dart';

// Features
import '../../parking/parking.dart';
import '../../zone_seats/zone_seats.dart';

part 'bookings_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
BookingsRepository bookingsRepository(BookingsRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return BookingsRepository(apiService: _apiService);
  // return MockBookingsRepository(apiService: _apiService);
}

class BookingsRepository {
  final ApiService _apiService;

  BookingsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: BookingsEndpoint.BASE.route(),
      data: data,
      converter: (response) => response.body['booking_id'] as int,
    );
  }

  Future<List<SpaceModel>> fetchAllParkingFloorBookedSpaces({
    required int eventId,
    required int pFloorId,
  }) async {
    return _apiService.getCollectionData<SpaceModel>(
      endpoint: BookingsEndpoint.PARKING_FLOOR_BOOKED_SPACES.route(
        parkingFloorId: pFloorId,
        eventId: eventId,
      ),
      converter: SpaceModel.fromJson,
    );
  }

  Future<List<SeatModel>> fetchAllZoneBookedSeats({
    required int zoneId,
    required int eventId,
  }) async {
    return _apiService.getCollectionData<SeatModel>(
      endpoint: BookingsEndpoint.ZONE_BOOKED_SEATS.route(
        zoneId: zoneId,
        eventId: eventId,
      ),
      converter: SeatModel.fromJson,
    );
  }
}

class MockBookingsRepository implements BookingsRepository {
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

  MockBookingsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<int> create({required JSON data}) {
    return Future.delayed(
      2.seconds,
      () => AppUtils.randomizer().nextInt(10),
    );
  }

  @override
  Future<List<SpaceModel>> fetchAllParkingFloorBookedSpaces({
    required int pFloorId,
    required int eventId,
  }) {
    return Future.delayed(2.seconds, () => mockSpaces[pFloorId]!);
  }

  @override
  Future<List<SeatModel>> fetchAllZoneBookedSeats({
    required int zoneId,
    required int eventId,
  }) {
    return Future.delayed(
      2.seconds,
      () => const [],
    );
  }
}
