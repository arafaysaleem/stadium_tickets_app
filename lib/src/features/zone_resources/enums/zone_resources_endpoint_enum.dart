// ignore_for_file: constant_identifier_names

enum ZoneResourcesEndpoint {
  BASE,
  BY_ID;

  const ZoneResourcesEndpoint();

  static const _baseRoute = '/zones-resources';

  /// Returns the path for zone resources [endpoint].
  ///
  /// Specify zone resource [id] to get the path for a specific zone resource.
  String route({int? id}) {
    const path = ZoneResourcesEndpoint._baseRoute;
    switch (this) {
      case ZoneResourcesEndpoint.BASE:
        return path;
      case ZoneResourcesEndpoint.BY_ID:
        {
          assert(id != null, 'zoneResourceId is required for BY_ID endpoint');
          return '$path/$id';
        }
    }
  }
}
