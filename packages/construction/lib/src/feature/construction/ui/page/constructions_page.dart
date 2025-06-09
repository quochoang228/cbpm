import 'package:ag/ag.dart';
import 'package:construction/src/feature/construction/ui/widget/construction_item.dart';
import 'package:ds/ds.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/constructions_provider.dart';
import '../widget/search.dart';

class ConstructionsPage extends StatefulHookConsumerWidget {
  const ConstructionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConstructionsPageState();
}

class _ConstructionsPageState extends ConsumerState<ConstructionsPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    Future.microtask(
      () => ref.read(constructionsProvider.notifier).findAllByStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Danh sách công trình',
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: DSColors.backgroundWhite,
            child: BaseSearchText(
              onTextCommit: (content) {
                ref.read(constructionsProvider.notifier).search(
                      keySearch: content,
                    );
              },
              onTextClear: () {
                ref.read(constructionsProvider.notifier).search(
                      keySearch: null,
                    );
                return true;
              },
              hintText: 'Tìm kiếm công trình',
              searchController: BaseSearchTextController()
                ..isClearShow = true
                ..isActionShow = true,
            ),
          ),
          Expanded(
              child: MatchDataState(
            state: ref.watch(constructionsProvider),
            fetched: (p0) => ListView.separated(
              itemCount: p0.data.length,
              padding: EdgeInsets.symmetric(vertical: DSSpacing.spacing2),
              separatorBuilder: (context, index) =>
                  const Gap(DSSpacing.spacing2),
              itemBuilder: (context, index) {
                return ConstructionItem(
                  item: p0.data[index],
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
