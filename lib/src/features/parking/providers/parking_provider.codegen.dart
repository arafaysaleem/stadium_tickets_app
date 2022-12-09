import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/extensions/extensions.dart';

// Models
import '../models/parking_floor_model.codegen.dart';

part 'parking_provider.codegen.g.dart';

final mockParkingFloors = [
  ParkingFloorModel.fromJson(<String, dynamic>{
    'p_floor_id': 11,
    'floor_number': 1,
    'spaces_per_row': 17,
    'num_of_rows': 20,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
  }),
  ParkingFloorModel.fromJson(<String, dynamic>{
    'p_floor_id': 2,
    'floor_number': 2,
    'spaces_per_row': 13,
    'num_of_rows': 7,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
  }),
  ParkingFloorModel.fromJson(<String, dynamic>{
    'p_floor_id': 1,
    'floor_number': 3,
    'spaces_per_row': 14,
    'num_of_rows': 17,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
  }),
];

final currentPFloorNoProvider = StateProvider.autoDispose<int>((_) => 1);

final currentParkingFloorProvider = StateProvider.autoDispose<ParkingFloorModel?>(
  (ref) {
    final floorNumber = ref.watch(currentPFloorNoProvider);
    return mockParkingFloors.firstWhere((z) => z.floorNumber == floorNumber);
  },
);

@riverpod
Future<List<ParkingFloorModel>> parkingFloorsFuture(ParkingFloorsFutureRef ref) async {
  return Future.delayed(2.seconds, () => mockParkingFloors);
}
