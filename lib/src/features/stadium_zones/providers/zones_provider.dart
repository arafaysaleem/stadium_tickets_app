import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../stadium_zones/models/zone_model.codegen.dart';

final mockZone = ZoneModel.fromJson(<String, dynamic>{
  'zone_id': 9,
  'name': 'NORTH',
  'seats_per_row': 14,
  'num_of_rows': 17,
  'color_hex_code': '#FDDF00',
  'z_type_id': 1,
  'created_at': '2022-10-15T15:00:40.352Z',
  'updated_at': '2022-10-15T15:00:40.352Z',
  'type': {'z_type_id': 1, 'type': 'vip', 'price': 70}
});

final currentZoneProvider = StateProvider.autoDispose<ZoneModel?>((_) => mockZone);

final currentZoneNoProvider = StateProvider.autoDispose<int?>((_) => null);
