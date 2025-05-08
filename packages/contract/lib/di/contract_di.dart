part of '../../contract.dart';

class ContractDependency implements BaseDependencies{

@override
void apiDependency() {
  final dependencies = Dependencies();

  dependencies.registerFactory<IOCContractRequestApi>(
        () => IOCContractRequestApiImpl(apiGateway: dependencies.getIt()),
  );

  dependencies.registerFactory<IOCContractLocalStorage>(
        () => IOCContractLocalStorageImpl(storage: dependencies.getIt()),
  );
}

@override
void repositoryDependency() {
  final dependencies = Dependencies();

  dependencies.registerLazySingleton<IOCContactRepository>(
        () => IOCContactRepositoryImpl(
      api: dependencies.getIt(),
      localStorage: dependencies.getIt(),
    ),
  );
}

@override
void init() {
  apiDependency();
  repositoryDependency();

  Dependencies().registerLazySingleton<IOCContractService>(
        () => IOCContractService(Dependencies().getIt()),
  );

  injectorRouterApp();
}
}