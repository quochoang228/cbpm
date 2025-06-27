import 'package:di/di.dart';
import 'package:router/router.dart';

import '../feature/root.dart';
import '../feature/splash.dart';
import 'paths.dart';

void injectorRouterApp() {

  AppRouterGuard.initializeAutoRestore();
  // Initialize the router service
  Dependencies().registerSingleton<RouterService>(
    RouterService(),
  );

  Dependencies().getIt<RouterService>().registerRoutes([
    RouteEntry(
      path: Paths.splash,
      builder: (context, state) => const Splash(),
    ),
    RouteEntry(
      path: Paths.root,
      builder: (context, state) => const Root(),
    ),
  ]);
}
