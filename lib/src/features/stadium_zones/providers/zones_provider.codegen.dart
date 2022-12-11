import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../models/zone_model.codegen.dart';
import '../models/zone_seating_model.codegen.dart';

// Repositories
import '../repositories/zones_repository.codegen.dart';

part 'zones_provider.codegen.g.dart';

final currentZoneProvider = StateProvider.autoDispose<ZoneModel?>((_) => null);

@riverpod
Future<Map<int, ZoneModel>> zonesFuture(ZonesFutureRef ref) async {
  final zones = await ref.watch(zonesControllerProvider).getAllZones();
  final zoneMap = {for (var e in zones) e.number: e};
  return zoneMap;
}

/// A provider used to access instance of this service
@riverpod
ZonesController zonesController(ZonesControllerRef ref) {
  return ZonesController(ref.watch(zonesRepositoryProvider));
}

class ZonesController {
  final ZonesRepository _zonesRepository;

  ZonesController(this._zonesRepository);

  Future<List<ZoneModel>> getAllZones([JSON? queryParams]) async {
    return _zonesRepository.fetchAllZones(queryParameters: queryParams);
  }

  Future<ZoneSeatingModel> getAllZoneSeats(int id) async {
    return _zonesRepository.fetchAllZoneSeats(zoneId: id);
  }
}
