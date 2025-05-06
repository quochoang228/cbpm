import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Root extends StatefulHookConsumerWidget {
  const Root({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootState();
}
class _RootState extends ConsumerState<Root> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}