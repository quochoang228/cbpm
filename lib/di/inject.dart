import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contract/contract.dart';
import 'package:di/di.dart';

void injectorApp() {
  Dependencies().registerFactory(
    () => Dio(BaseOptions(baseUrl: 'https://apis.congtrinhviettel.com.vn/ioc-mobile')),
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
      // cacheDuration: null,
      // refreshAccessToken: () async => '',
      // maxRequests: null,
      // rateLimitDuration: null,
      // failureThreshold: null,
      // circuitResetTimeout: null,
    ),
  );

  AuthDependency().init();
  ContractDependency().init();
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
