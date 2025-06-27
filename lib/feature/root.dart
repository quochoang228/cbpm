import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:cdn/cdn.dart';
import 'package:contract/router/paths.dart' as contractPath;
import 'package:di/di.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wo/router/paths.dart' as woPath;
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/menu_item.dart';

class Root extends StatefulHookConsumerWidget {
  const Root({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  DateTime? _lastBackPressed;

  Future<User?> getUser() {
    final authService = Dependencies().getIt<AuthService>();
    final user = authService.getUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var user = useState<User?>(User());

    useMemoized(
      () async {
        user.value = await getUser();
      },
    );

    return Scaffold(
      backgroundColor: DSColors.backgroundWhite,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          final now = DateTime.now();
          if (_lastBackPressed == null ||
              now.difference(_lastBackPressed!) >
                  const Duration(milliseconds: 700)) {
            _lastBackPressed = now;

            // Hiển thị thông báo
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Nhấn back một lần nữa để thoát ứng dụng'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            // Thoát ứng dụng
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(DSSpacing.spacing4),
                  bottomRight: Radius.circular(DSSpacing.spacing4),
                ),
                image: DecorationImage(
                  image: CDNAssets.images.header.provider(),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: DSSpacing.spacing4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào',
                              style: DSTextStyle.titleSmall
                                  .applyColor(DSColors.textOnColor),
                            ),
                            Text(
                              user.value?.email ?? 'Chưa đăng nhập',
                              style: DSTextStyle.bodySmall
                                  .applyColor(DSColors.textOnColor),
                            ),
                          ],
                        ),
                      ),
                      user.value?.email != null
                          ? InkWell(
                              onTap: () async {
                                await Dependencies()
                                    .getIt<ApiGateway>()
                                    .setToken('');
                                var data = await Dependencies()
                                    .getIt<AuthService>()
                                    .logout();
                                if (data) {
                                  user.value = await getUser();
                                }
                              },
                              child: Icon(
                                Icons.logout,
                                color: DSCoreColors.white,
                              ),
                            )
                          : DSButton(
                              label: 'Đăng nhập ngay',
                              backgroundColor: DSCoreColors.transparent,
                              onPressed: () async {
                                final authService =
                                    Dependencies().getIt<AuthService>();
                                final isLoggedIn = await authService
                                    .isLoggedIn(); // Kiểm tra trạng thái đăng nhập
                                if (!isLoggedIn) {
                                  await context.push(
                                      // authService.loginRouter
                                      AuthService.loginRouter);
                                  user.value = await getUser();
                                } else {
                                  // DSNormalToast.showSuccess(
                                  //   context: context,
                                  //   text: 'Đã đăng nhập',
                                  // );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(DSSpacing.spacing4),
                  child: Text(
                    'Tính năng',
                    style: DSTextStyle.headlineMedium.semiBold(),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: EdgeInsets.zero,
                  children: [
                    MenuItem(
                      title: 'AIO Partner',
                      image: CDNAssets.icons.menu1.svg(),
                      onTap: () {
                        // context.push(contractPath.Paths.listContract);
                      },
                    ),
                    MenuItem(
                      title: 'Hợp đồng điện tử',
                      image: CDNAssets.icons.menu1.svg(),
                      onTap: () {
                        context.push(contractPath.Paths.listContract);
                      },
                    ),
                    MenuItem(
                      title: 'Quản lý WO',
                      image: CDNAssets.icons.menu1.svg(),
                      onTap: () {
                        context.push(woPath.Paths.woListPage);
                      },
                    ),
                    MenuItem(
                      title: 'Công trình',
                      image: CDNAssets.icons.menu1.svg(),
                      onTap: () {
                        // context.push(woPath.Paths.woListPage);
                      },
                    ),
                    // MenuItem(
                    //   title: 'Yêu cầu tiếp xúc',
                    //   image: CDNAssets.icons.menu2.svg(),
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (context) {
                    //         return Container(
                    //           color: DSColors.backgroundWhite,
                    //           padding: const EdgeInsets.all(DSSpacing.spacing4),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.stretch,
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text(
                    //                 'Yêu cầu tiếp xúc',
                    //                 style: DSTextStyle.headlineMedium.semiBold(),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //               InkWell(
                    //                 onTap: () {
                    //                   context.pop();
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(DSSpacing.spacing4),
                    //                   child: Row(
                    //                     children: [
                    //                       CDNAssets.icons.connection.svg(
                    //                         colorFilter: ColorFilter.mode(
                    //                           DSColors.textBody,
                    //                           BlendMode.srcIn,
                    //                         ),
                    //                       ),
                    //                       const Gap(DSSpacing.spacing4),
                    //                       Text(
                    //                         'Yêu cầu tiếp xúc B2C',
                    //                         style: DSTextStyle.bodyMedium,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               InkWell(
                    //                 onTap: () {
                    //                   context.pop();
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(DSSpacing.spacing4),
                    //                   child: Row(
                    //                     children: [
                    //                       CDNAssets.icons.connection.svg(
                    //                         colorFilter: ColorFilter.mode(
                    //                           DSColors.textBody,
                    //                           BlendMode.srcIn,
                    //                         ),
                    //                       ),
                    //                       const Gap(DSSpacing.spacing4),
                    //                       Text(
                    //                         'Yêu cầu tiếp xúc B2B',
                    //                         style: DSTextStyle.bodyMedium,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
                // DSButton(
                //   label: 'Hợp đồng điện tử ',
                //   onPressed: () {
                //     context.push(contractPath.Paths.listContract);
                //   },
                // ),
                // SizedBox(height: 10),
                // DSButton(
                //   label: 'Quản lý YCTX',
                //   onPressed: () {
                //     context.push(woPath.Paths.woListPage);
                //   },
                // ),
                // DSButton(
                //   label: 'Đăng xuất',
                //   onPressed: () async {
                //     await Dependencies().getIt<ApiGateway>().setToken('');
                //     var data = await Dependencies().getIt<AuthService>().logout();
                //     if (data) {}
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
