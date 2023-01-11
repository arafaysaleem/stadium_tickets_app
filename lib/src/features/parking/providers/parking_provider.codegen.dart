import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../../events/events.dart';
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

@Riverpod(keepAlive: true)
Future<List<ParkingFloorModel>> parkingFloorsFuture(
  ParkingFloorsFutureRef ref,
) async {
  final parking = await ref.watch(parkingProvider).getAllParking();
  parking.sort((a, b) => a.floorNumber.compareTo(b.floorNumber));
  return parking;
}

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
ParkingProvider parking(ParkingRef ref) {
  return ParkingProvider(ref, ref.watch(parkingRepositoryProvider));
}

class ParkingProvider {
  final Ref ref;
  final ParkingRepository _parkingRepository;

  ParkingProvider(this.ref, this._parkingRepository);

  Future<List<ParkingFloorModel>> getAllParking([JSON? queryParams]) async {
    return _parkingRepository.fetchAllParking(queryParameters: queryParams);
  }

  Future<ParkingFloorSpacesModel> getAllParkingFloorSpaces(int id) async {
    final eventId = ref.read(currentEventProvider)!.eventId;
    return _parkingRepository.fetchAllParkingFloorSpaces(
      pFloorId: id,
      eventId: eventId,
    );
  }
}
