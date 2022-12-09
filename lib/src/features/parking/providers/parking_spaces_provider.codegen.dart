import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/extensions/extensions.dart';

// Models
import '../models/parking_floor_spaces_model.codegen.dart';
import '../models/space_model.codegen.dart';

// Providers
import 'parking_provider.codegen.dart';

part 'parking_spaces_provider.codegen.g.dart';

const mockSpaces = <int, ParkingFloorSpacesModel>{
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

@Riverpod(keepAlive: true)
Future<ParkingFloorSpacesModel> parkingSpacesFuture(
  ParkingSpacesFutureRef ref,
  int pFloorId,
) {
  return Future.delayed(3.seconds, () => mockSpaces[pFloorId]!);
}

@riverpod
List<SpaceModel> currentFloorSelectedSpaces(CurrentFloorSelectedSpacesRef ref) {
  final spacesMap = ref.watch(parkingSpacesProvider);
  final activeFloorNo = ref.watch(currentPFloorNoProvider);
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
    final floorNo = ref.read(currentPFloorNoProvider);
    state.update(
      floorNo,
      (value) => [...value, space],
      ifAbsent: () => [space],
    );
    state = {...state};
  }

  void removeSpace(SpaceModel space) {
    final floorNo = ref.read(currentPFloorNoProvider);
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
