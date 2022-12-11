// ignore_for_file: constant_identifier_names

enum EventsEndpoint {
  BASE,
  BY_ID;

  const EventsEndpoint();

  static const _baseRoute = '/events';

  /// Returns the path for events [endpoint].
  ///
  /// Specify event [id] to get the path for a specific event.
  String route({int? id}) {
    const path = EventsEndpoint._baseRoute;
    switch(this){
      case EventsEndpoint.BASE: return path;
      case EventsEndpoint.BY_ID: {
        assert(id != null, 'eventId is required for BY_ID endpoint');
        return '$path/$id';
      }
    }
  }
}
