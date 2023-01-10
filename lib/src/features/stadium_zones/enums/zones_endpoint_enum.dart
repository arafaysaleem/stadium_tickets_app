// ignore_for_file: constant_identifier_names

enum ZonesEndpoint {
  BASE,
  SEATS,
  RESOURCES,
  BY_ID;

  const ZonesEndpoint();

  static const _baseRoute = '/zones';
  static const _seatsRoute = 'seats';
  static const _resourcesRoute = 'resources';

  /// Returns the path for zones [endpoint].
  ///
  /// Specify zone [id] to get the path for a specific zone.
  String route({int? id}) {
    const path = ZonesEndpoint._baseRoute;
    switch (this) {
      case ZonesEndpoint.BASE:
        return path;
      case ZonesEndpoint.BY_ID:
        {
          assert(id != null, 'zoneId is required for BY_ID endpoint');
          return '$path/$id';
        }
      case ZonesEndpoint.SEATS:
        {
          assert(id != null, 'zoneId is required for SEATS endpoint');
          const seats = ZonesEndpoint._seatsRoute;
          return '$path/$id/$seats';
        }
      case ZonesEndpoint.RESOURCES:
        {
          assert(id != null, 'zoneId is required for RESOURCES endpoint');
          const resources = ZonesEndpoint._resourcesRoute;
          return '$path/$id/$resources';
        }
    }
  }
}
