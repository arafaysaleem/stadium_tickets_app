// ignore_for_file: constant_identifier_names

enum BookingsEndpoint {
  BASE,
  BY_ID;

  const BookingsEndpoint();

  static const _baseRoute = '/bookings';

  /// Returns the path for bookings [endpoint].
  ///
  /// Specify booking [id] to get the path for a specific booking.
  String route({int? id}) {
    const path = BookingsEndpoint._baseRoute;
    switch(this){
      case BookingsEndpoint.BASE: return path;
      case BookingsEndpoint.BY_ID: {
        assert(id != null, 'bookingId is required for BY_ID endpoint');
        return '$path/$id';
      }
    }
  }
}
