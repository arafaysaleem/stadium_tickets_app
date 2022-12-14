import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/parking_floor_spaces_model.codegen.dart';
import '../models/space_model.codegen.dart';

// Providers
import 'parking_provider.codegen.dart';

part 'parking_spaces_provider.codegen.g.dart';

@Riverpod(keepAlive: true)
Future<ParkingFloorSpacesModel> parkingSpacesFuture(
  ParkingSpacesFutureRef ref,
  int pFloorId,
) {
  return ref.watch(parkingProvider).getAllParkingFloorSpaces(pFloorId);
}

@riverpod
List<SpaceModel> currentFloorSelectedSpaces(CurrentFloorSelectedSpacesRef ref) {
  final spacesMap = ref.watch(parkingSpacesProvider);
  final activeFloorNo = ref.watch(currentParkingFloorProvider)!.floorNumber;
  return spacesMap[activeFloorNo] ?? [];
}

final confirmedParkingSpacesProvider =
    StateProvider.autoDispose<Map<int, List<SpaceModel>>>(
  (ref) {
    return {};
  },
);

@riverpod
class ParkingSpaces extends _$ParkingSpaces {
  @override
  Map<int, List<SpaceModel>> build() {
    final parkingSpaces = ref
        .watch(confirmedParkingSpacesProvider)
        .map((key, value) => MapEntry(key, [...value]));
    return {...parkingSpaces};
  }

  void selectSpace(SpaceModel space) {
    final floorNo = ref.read(currentParkingFloorProvider)!.floorNumber;
    state.update(
      floorNo,
      (value) => [...value, space],
      ifAbsent: () => [space],
    );
    state = {...state};
  }

  void removeSpace(SpaceModel space) {
    final floorNo = ref.read(currentParkingFloorProvider)!.floorNumber;
    state.update(
      floorNo,
      (value) {
        value.remove(space);
        return [...value];
      },
      ifAbsent: () => [space],
    );
    state = {...state};
  }
}
