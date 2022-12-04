import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Routers
import 'src/config/routing/app_router.dart';
import 'src/config/routing/routes.dart';

// Helpers
import 'src/helpers/constants/app_colors.dart';
import 'src/helpers/constants/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Stadium Tickets App';
    const showDebugBanner = false;
    final navigatorObservers = <NavigatorObserver>[SentryNavigatorObserver()];
    return ProviderScope(
      child: MaterialApp(
        title: title,
        navigatorObservers: navigatorObservers,
        debugShowCheckedModeBanner: showDebugBanner,
        color: AppColors.primaryColor,
        theme: AppThemes.mainTheme,
        initialRoute: Routes.initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorKey: AppRouter.navigatorKey,
      ),
    );
  }
}
