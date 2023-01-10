import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Models
import '../models/parking_floor_spaces_model.codegen.dart';
import '../models/space_model.codegen.dart';

// Providers
import 'parking_provider.codegen.dart';

part 'parking_spaces_provider.codegen.g.dart';

@Riverpod(keepAlive: true)
Future<ParkingFloorSpacesModel?> parkingSpacesFuture(
  ParkingSpacesFutureRef ref,
  int? pFloorId,
) {
  if (pFloorId == null) return Future.value();
  return ref.watch(parkingProvider).getAllParkingFloorSpaces(pFloorId);
}

@riverpod
List<SpaceModel> currentFloorSelectedSpaces(CurrentFloorSelectedSpacesRef ref) {
  final spacesMap = ref.watch(parkingSpacesProvider);
  final activeFloorId = ref.watch(currentParkingFloorProvider)!.pFloorId;
  return spacesMap[activeFloorId] ?? [];
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
    final floor = ref.read(currentParkingFloorProvider)!;
    state.update(
      floor.pFloorId,
      (value) => [...value, space],
      ifAbsent: () => [space],
    );
    state = {...state};
  }

  void removeSpace(SpaceModel space) {
    final pFloorId = ref.read(currentParkingFloorProvider)!.pFloorId;
    state.update(
      pFloorId,
      (value) {
        value.remove(space);
        return [...value];
      },
      ifAbsent: () => [space],
    );
    state = {...state};
  }
}
