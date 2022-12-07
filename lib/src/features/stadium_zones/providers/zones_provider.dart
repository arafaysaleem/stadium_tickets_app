import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/zone_model.codegen.dart';

final mockZones = [
  ZoneModel.fromJson(<String, dynamic>{
    'zone_id': 11,
    'name': 'WEST',
    'seats_per_row': 17,
    'num_of_rows': 20,
    'color_hex_code': '#FDDF00',
    'z_type_id': 1,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
    'type': {'z_type_id': 1, 'type': 'vip', 'price': 70}
  }),
  ZoneModel.fromJson(<String, dynamic>{
    'zone_id': 2,
    'name': 'SOUTH DECK',
    'seats_per_row': 13,
    'num_of_rows': 7,
    'color_hex_code': '#FDDF00',
    'z_type_id': 2,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
    'type': {'z_type_id': 2, 'type': 'general', 'price': 10}
  }),
  ZoneModel.fromJson(<String, dynamic>{
    'zone_id': 1,
    'name': 'NORTH',
    'seats_per_row': 14,
    'num_of_rows': 17,
    'color_hex_code': '#FDDF00',
    'z_type_id': 3,
    'created_at': '2022-10-15T15:00:40.352Z',
    'updated_at': '2022-10-15T15:00:40.352Z',
    'type': {'z_type_id': 3, 'type': 'premium', 'price': 40}
  }),
];

final currentZoneIdProvider = StateProvider.autoDispose<int?>((_) => null);

final currentZoneProvider = StateProvider.autoDispose<ZoneModel?>(
  (ref) {
    final zoneId = ref.watch(currentZoneIdProvider);
    if (zoneId == null) return null;
    return mockZones.firstWhere((z) => z.zoneId == zoneId || z.zoneId == 1);
  },
);
