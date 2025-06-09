import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contract/contract.dart';
import 'package:di/di.dart';
import 'package:wo/wo.dart';

void injectorApp() {
  Dependencies().registerFactory(
    () => Dio(BaseOptions(baseUrl: 'http://10.248.242.247:8720/ioc-service')),
  );

  Dependencies().registerLazySingleton<ApiGateway>(
    () => ApiGateway(
      dio: Dependencies().getIt<Dio>(),
      getAccessToken: () async => '',
      onTokenExpired: () {
        print("🔐 Token Expired");
      },
      connectivity: Connectivity(),
      onTrack: (event, data) {
        print("📊 Tracking Event: $event - $data");
      },
    ),
  );

  AuthDependency().init();
  ContractDependency().init();
  WoDependency().init();
  configLogin();
}

configLogin() {
  Dependencies().getIt<AuthService>().setUrl(
    {
      "URL_LOGIN": "/service/login",
      "URL_FORGET_PASSWORD": "/login/forgot-password",
      "URL_REGISTER": "/register",
    }
  );
}
