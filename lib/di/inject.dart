import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contract/contract.dart';
import 'package:di/di.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:router/router.dart';
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
        // print("🔐 Token Expired");
        var context = RouterService.currentContext;
        if (context != null) {
          showDialog(
              context: context,
              builder: (context) {
                return PopScope(
                  canPop: false,
                  child: AlertDialog(
                    title: Text(
                      "Phiên làm việc hết hạn",
                      style: DSTextStyle.bodyLarge.medium(),
                    ),
                    content: Text(
                      "Phiên làm việc của bạn đã hết hạn. Vui lòng đăng nhập lại.",
                      style: DSTextStyle.bodySmall,
                    ),
                    actions: [
                      DSButton(
                          label: "Đăng nhập lại",
                          onPressed: () async {
                            await Dependencies()
                                .getIt<ApiGateway>()
                                .setToken('');
                            await Dependencies().getIt<AuthService>().logout();
                            RouterService.navigateTo('/');
                            // Navigator.of(context).pushReplacementNamed('/login');
                          }),
                    ],
                  ),
                );
              });
        }
      },
      refreshAccessToken: () async => null,
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
  Dependencies().getIt<AuthService>().setUrl({
    "URL_LOGIN": "/service/login",
    "URL_FORGET_PASSWORD": "/login/forgot-password",
    "URL_REGISTER": "/register",
  });
}
