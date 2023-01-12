// ignore_for_file: constant_identifier_names

enum ParkingEndpoint {
  BASE,
  BY_ID;

  const ParkingEndpoint();

  static const _baseRoute = '/parking-floors';

  /// Returns the path for parkings [endpoint].
  ///
  /// Specify parking floor [id] to get the path for a specific parking.
  String route({int? id}) {
    const path = ParkingEndpoint._baseRoute;
    switch (this) {
      case ParkingEndpoint.BASE:
        return path;
      case ParkingEndpoint.BY_ID:
        {
          assert(id != null, 'parkingFloorId is required for BY_ID endpoint');
          return '$path/$id';
        }
    }
  }
}
