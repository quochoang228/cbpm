import 'package:di/di.dart';
import 'package:router/router.dart';

import '../entities/wo_detail.dart';
import '../wo.dart';
import 'paths.dart';

void injectorRouterApp() {
  Dependencies().registerSingleton<RouterService>(
    RouterService(),
  );

  Dependencies().getIt<RouterService>().registerRoutes([
    RouteEntry(
      path: Paths.woListPage,
      protected: true,
      builder: (context, state) => const WoListPage(),
    ),
    RouteEntry(
      path: Paths.woDetailPage,
      protected: true,
      builder: (context, state) => WoDetailPage(
        woHcId: state.extra as int,
      ),
    ),
    RouteEntry(
      path: Paths.customerFeedbackSurveyPage,
      protected: true,
      builder: (context, state) => CustomerFeedbackSurveyPage(
        woDetail: state.extra as WoDetail,
      ),
    ),
  ]);
}
