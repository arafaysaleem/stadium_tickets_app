// ignore_for_file: constant_identifier_names

enum BookingsEndpoint {
  BASE,
  PROCESS_PAYMENT,
  ZONE_BOOKED_SEATS,
  PARKING_FLOOR_BOOKED_SPACES,
  BY_ID;

  const BookingsEndpoint();

  static const _baseRoute = '/event-bookings';
  static const _payment = 'process-payment';
  static const _spacesRoute = 'spaces';
  static const _seatsRoute = 'seats';
  static const _zonesRoute = 'zones';
  static const _parkingRoute = 'parking-floors';

  /// Returns the path for bookings [endpoint].
  ///
  /// Specify booking [id] to get the path for a specific booking.
  /// Specify booking [eventId] to get the path for a specific event's booking.
  /// Specify booking [zoneId] to get the path for a specific booking event's zone's bookings.
  /// Specify booking [parkingFloorId] to get the path for a specific event's parking's bookings.
  String route({int? id, int? eventId, int? parkingFloorId, int? zoneId}) {
    const path = BookingsEndpoint._baseRoute;
    switch (this) {
      case BookingsEndpoint.BASE:
        return path;
      case BookingsEndpoint.BY_ID:
        {
          assert(id != null, 'bookingId is required for BY_ID endpoint');
          return '$path/$id';
        }
      case BookingsEndpoint.PROCESS_PAYMENT:
        {
          assert(
            id != null,
            'bookingId is required for PROCESS_PAYMENT endpoint',
          );
          const payments = BookingsEndpoint._payment;
          return '$path/$id/$payments';
        }
      case BookingsEndpoint.ZONE_BOOKED_SEATS:
        {
          assert(
            eventId != null,
            'eventId is required for ZONE_BOOKED_SEATS endpoint',
          );
          assert(
            zoneId != null,
            'zoneId is required for ZONE_BOOKED_SEATS endpoint',
          );
          const seats = BookingsEndpoint._seatsRoute;
          const zones = BookingsEndpoint._zonesRoute;
          return '$path/$eventId/$zones/$zoneId/$seats';
        }
      case BookingsEndpoint.PARKING_FLOOR_BOOKED_SPACES:
        {
          assert(
            eventId != null,
            'eventId is required for PARKING_FLOOR_BOOKED_SPACES endpoint',
          );
          assert(
            parkingFloorId != null,
            'parkingFloorId is required for PARKING_FLOOR_BOOKED_SPACES endpoint',
          );
          const spaces = BookingsEndpoint._spacesRoute;
          const parking = BookingsEndpoint._parkingRoute;
          return '$path/$eventId/$parking/$parkingFloorId/$spaces';
        }
    }
  }
}
