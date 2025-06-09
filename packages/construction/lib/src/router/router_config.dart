import 'package:di/di.dart';
import 'package:router/router.dart';

import '../entities/construction_dto.dart';
import '../feature/construction/ui/page/construction_detail_page.dart';
import '../feature/construction/ui/page/constructions_page.dart';
import 'paths.dart';

void injectorRouterApp() {
  Dependencies().registerSingleton<RouterService>(
    RouterService(),
  );

  Dependencies().getIt<RouterService>().registerRoutes([
    RouteEntry(
      path: ConstructionPaths.construction,
      protected: true,
      builder: (context, state) => const ConstructionsPage(),
    ),
    RouteEntry(
      path: ConstructionPaths.constructionDetail,
      protected: true,
      builder: (context, state) => ConstructionDetailPage(
        constructionDto: state.extra as ConstructionDto,
      ),
    ),
  ]);
}
