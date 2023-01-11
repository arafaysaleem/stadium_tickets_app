// ignore_for_file: constant_identifier_names

enum BookingsEndpoint {
  BASE,
  PROCESS_PAYMENT,
  BY_ID;

  const BookingsEndpoint();

  static const _baseRoute = '/event-bookings';
  static const _payment = 'process-payment';

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
      case BookingsEndpoint.PROCESS_PAYMENT: {
        assert(id != null, 'bookingId is required for PROCESS_PAYMENT endpoint');
        const payments = BookingsEndpoint._payment;
        return '$path/$id/$payments';
      }
    }
  }
}
