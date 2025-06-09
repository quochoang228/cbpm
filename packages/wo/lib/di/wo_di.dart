part of '../../wo.dart';

class WoDependency implements BaseDependencies {
  @override
  void apiDependency() {
    final dependencies = Dependencies();

    dependencies.registerFactory<IOCWoApi>(
          () => IOCWoApiImpl(apiGateway: dependencies.getIt()),
    );
  }

  @override
  void repositoryDependency() {
    final dependencies = Dependencies();

    dependencies.registerLazySingleton<IOCWoRepository>(
          () => IOCWoRepositoryImpl(
        api: dependencies.getIt(),
      ),
    );
  }

  @override
  void init() {
    apiDependency();
    repositoryDependency();

    // Dependencies().registerLazySingleton<IOCContractService>(
    //       () => IOCContractService(Dependencies().getIt()),
    // );

    injectorRouterApp();
  }
}
