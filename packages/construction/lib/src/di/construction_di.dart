import 'package:di/di.dart';

import '../data/api/construction_api.dart';
import '../data/local/construction_storage.dart';
import '../data/repository/construction_repository.dart';
import '../router/router_config.dart';
import '../services/construction_service.dart';

class ConstructionDependency implements BaseDependencies {
  @override
  void apiDependency() {
    final dependencies = Dependencies();

    dependencies.registerFactory<ConstructionApi>(
      () => ConstructionApiImpl(apiGateway: dependencies.getIt()),
    );

    dependencies.registerFactory<ConstructionLocalStorage>(
      () => ConstructionLocalStorageImpl(storage: dependencies.getIt()),
    );
  }

  @override
  void repositoryDependency() {
    final dependencies = Dependencies();

    dependencies.registerLazySingleton<ConstructionRepository>(
      () => ConstructionRepositoryImpl(
        api: dependencies.getIt(),
        localStorage: dependencies.getIt(),
      ),
    );
  }

  @override
  void init() {
    apiDependency();
    repositoryDependency();

    Dependencies().registerLazySingleton<ConstructionService>(
      () => ConstructionService(Dependencies().getIt()),
    );

    injectorRouterApp();
  }
}
