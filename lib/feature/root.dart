import 'package:construction/construction.dart';
import 'package:contract/router/paths.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Root extends StatefulHookConsumerWidget {
  const Root({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Super App Nội Bộ',
          style: DSTextStyle.headlineLarge.semiBold(),
        ),
        backgroundColor: DSColors.backgroundWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSButton(
              label: 'Hợp đồng điện tử ',
              onPressed: () {
                context.push(Paths.listContract);
              },
            ),
            const Gap(DSSpacing.spacing4),
            DSButton(
              label: 'Construction',
              onPressed: () {
                context.push(ConstructionPaths.construction);
              },
            ),
          ],
        ),
      ),
    );
  }
}
