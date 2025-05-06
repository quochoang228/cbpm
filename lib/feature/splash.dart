import 'dart:async';

import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/paths.dart';

class Splash extends StatefulHookConsumerWidget {
  const Splash({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  double percent = 0.0;
  Timer? timer;
  int _start = 1;
  final int _totalTime = 1;

  @override
  void initState() {
    super.initState();

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            getLocalUser();
          });
        } else {
          setState(() {
            _start--;
            percent = 1 - _start / _totalTime;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getLocalUser() async {
    // await ref.read(localUserProvider.notifier).fetchLocalUser();
    checkAuth();
  }

  void checkAuth() {
    // final token = ref.watch(tokenProvider);
    // final isKeepLogin = ref.watch(isKeepLoginProvider);
    // context.pushReplacement(
    // token.isEmpty ? Paths.login : (isKeepLogin ? Paths.root : Paths.login));
    context.pushReplacement(Paths.root);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSCoreColors.white,
      body: Center(
        child: Text(
          'cBPM',
          style: TextStyle(
            color: DSCoreColors.black,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
