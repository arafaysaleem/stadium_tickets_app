import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../models/parking_floor_model.codegen.dart';
import '../models/parking_floor_spaces_model.codegen.dart';

// Repositories
import '../repositories/parking_repository.codegen.dart';

part 'parking_provider.codegen.g.dart';

final currentParkingFloorProvider =
    StateProvider.autoDispose<ParkingFloorModel?>(
  (ref) {
    return ref.watch(parkingFloorsFutureProvider).asData?.value.first;
  },
);

@riverpod
Future<List<ParkingFloorModel>> parkingFloorsFuture(
  ParkingFloorsFutureRef ref,
) {
  return ref.watch(parkingProvider).getAllParking();
}

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
ParkingProvider parking(ParkingRef ref) {
  return ParkingProvider(ref.watch(parkingRepositoryProvider));
}

class ParkingProvider {
  final ParkingRepository _parkingRepository;

  ParkingProvider(this._parkingRepository);

  Future<List<ParkingFloorModel>> getAllParking([JSON? queryParams]) async {
    return _parkingRepository.fetchAllParking(queryParameters: queryParams);
  }

  Future<ParkingFloorSpacesModel> getAllParkingFloorSpaces(int id) async {
    return _parkingRepository.fetchAllParkingFloorSpaces(pFloorId: id);
  }
}
