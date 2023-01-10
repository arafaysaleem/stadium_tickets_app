import 'package:riverpod_annotation/riverpod_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Models
import '../../stadium_zones/stadium_zones.dart';
import '../models/zone_resource_model.codegen.dart';

// Repositories
import '../repositories/zone_resources_repository.codegen.dart';

part 'zone_resources_provider.codegen.g.dart';

@riverpod
Future<List<ZoneResourceModel>> zoneResourcesFuture(
  ZoneResourcesFutureRef ref,
) async {
  final zoneId = ref.watch(currentZoneProvider)!.zoneId;
  return ref.watch(zoneResourcesControllerProvider).getAllZoneResources(zoneId);
}

/// A provider used to access instance of this service
@riverpod
ZoneResourcesController zoneResourcesController(
  ZoneResourcesControllerRef ref,
) {
  return ZoneResourcesController(ref.watch(zoneResourcesRepositoryProvider));
}

class ZoneResourcesController {
  final ZoneResourcesRepository _zoneResourcesRepository;

  ZoneResourcesController(this._zoneResourcesRepository);

  Future<List<ZoneResourceModel>> getAllZoneResources(int zoneId, [
    JSON? queryParams,
  ]) async {
    return _zoneResourcesRepository.fetchAllZoneResources(
      zoneId: zoneId,
      queryParameters: queryParams,
    );
  }
}
