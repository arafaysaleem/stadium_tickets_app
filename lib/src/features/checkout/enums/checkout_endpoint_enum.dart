// ignore_for_file: constant_identifier_names

enum CheckoutEndpoint {
  BASE,
  BY_ID;

  const CheckoutEndpoint();

  static const _baseRoute = '/checkout';

  /// Returns the path for checkout [endpoint].
  ///
  /// Specify booking [id] to get the path for a specific booking.
  String route({int? id}) {
    const path = CheckoutEndpoint._baseRoute;
    switch(this){
      case CheckoutEndpoint.BASE: return path;
      case CheckoutEndpoint.BY_ID: {
        assert(id != null, 'paymentId is required for BY_ID endpoint');
        return '$path/$id';
      }
    }
  }
}
