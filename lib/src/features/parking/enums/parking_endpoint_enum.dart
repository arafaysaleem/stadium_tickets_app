// ignore_for_file: constant_identifier_names

enum ParkingEndpoint {
  BASE,
  SPACES,
  BY_ID;

  const ParkingEndpoint();

  static const _baseRoute = '/parking-floors';
  static const _spacesRoute = 'spaces';
  static const _eventsRoute = 'events';

  /// Returns the path for parkings [endpoint].
  ///
  /// Specify parking floor [id] to get the path for a specific parking.
  /// Specify event [eventId] to get the path for a specific event's parking.
  String route({int? id, int? eventId}) {
    const path = ParkingEndpoint._baseRoute;
    switch (this) {
      case ParkingEndpoint.BASE:
        return path;
      case ParkingEndpoint.BY_ID:
        {
          assert(id != null, 'parkingFloorId is required for BY_ID endpoint');
          return '$path/$id';
        }
      case ParkingEndpoint.SPACES:
        {
          assert(id != null, 'parkingFloorId is required for SPACES endpoint');
          assert(eventId != null, 'eventId is required for SPACES endpoint');
          const spaces = ParkingEndpoint._spacesRoute;
          const events = ParkingEndpoint._eventsRoute;
          return '$path/$id/$events/$eventId/$spaces';
        }
    }
  }
}
