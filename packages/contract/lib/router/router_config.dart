import 'package:di/di.dart';
import 'package:router/router.dart';

import '../contract.dart';
import 'paths.dart';

void injectorRouterApp() {
  Dependencies().registerSingleton<RouterService>(
    RouterService(),
  );

  Dependencies().getIt<RouterService>().registerRoutes([
    RouteEntry(
      path: Paths.listContract,
      protected: true,
      builder: (context, state) => const ContractListPage(),
    ),
    RouteEntry(
      path: Paths.detailContract,
      protected: true,
      builder: (context, state) => ContractDetailPage(
        contractArgumentsDto: state.extra as ContractArgumentsDto,
      ),
    ),
    RouteEntry(
      path: Paths.contactHistory,
      protected: true,
      builder: (context, state) => ContactHistoryPage(
        contractPmxlId: state.extra as int,
      ),
    ),
  ]);
}
