// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Helpers
import '../../helpers/typedefs.dart';

// Screens
import '../../features/events/events_screen.dart';
import '../../features/stadium_zones/stadium_zones_screen.dart';
import '../../features/zone_seats/zone_seats_screen.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The route to be loaded when app launches
  static const String initialRoute = EventsScreenRoute;

  /// The route to be loaded in case of unrecognized route name
  static const String fallbackRoute = NotFoundScreenRoute;

  /// The name of the route for events screen
  static const String EventsScreenRoute = '/events-screen';

  /// The name of the route for zone seats screen
  static const String ZoneSeatsScreenRoute = '/zone-seats-screen';

  /// The name of the route for stadium zones screen
  static const String StadiumZonesScreenRoute = '/stadium-zones-screen';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    EventsScreenRoute: (_) => const EventsScreen(),
    StadiumZonesScreenRoute: (_) => const StadiumZonesScreen(),
    ZoneSeatsScreenRoute: (_) => const ZoneSeatsScreen(),
    NotFoundScreenRoute: (_) => const SizedBox.shrink(),
  };

  static RouteBuilder getRoute(String? routeName) {
    return routeExists(routeName)
        ? _routesMap[routeName]!
        : _routesMap[Routes.NotFoundScreenRoute]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
