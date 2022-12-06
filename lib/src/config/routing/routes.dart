// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Helpers
import '../../helpers/typedefs.dart';

// Screens
import '../../features/tickets_summary/tickets_summary.dart';
import '../../features/events/events.dart';
import '../../features/stadium_zones/stadium_zones.dart';
import '../../features/zone_resources/zone_resources.dart';
import '../../features/zone_seats/zone_seats.dart';

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

  /// The name of the route for zone resources screen
  static const String ZoneResourcesScreenRoute = '/zone-resources-screen';

  /// The name of the route for stadium zones screen
  static const String StadiumZonesScreenRoute = '/stadium-zones-screen';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  /// The name of the route for tickets summary screen
  static const String TicketsSummaryScreenRoute = '/tickets-summary-screen';

  /// The name of the route for checkout screen
  static const String CheckoutScreenRoute = '/checkout-screen';

  /// The name of the route for parking floor screen
  static const String ParkingFloorsScreenRoute = '/parking-floors-screen';

  /// The name of the route for parking spaces screen
  static const String ParkingSpacesScreenRoute = '/parking-spaces-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    EventsScreenRoute: (_) => const EventsScreen(),
    StadiumZonesScreenRoute: (_) => const StadiumZonesScreen(),
    ZoneResourcesScreenRoute: (_) => const ZoneResourcesScreen(),
    ZoneSeatsScreenRoute: (_) => const ZoneSeatsScreen(),
    ParkingFloorsScreenRoute: (_) => const SizedBox.shrink(),
    ParkingSpacesScreenRoute: (_) => const SizedBox.shrink(),
    CheckoutScreenRoute: (_) => const SizedBox.shrink(),
    TicketsSummaryScreenRoute: (_) => const TicketSummaryScreen(),
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