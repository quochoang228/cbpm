part of '../../contract.dart';

class ContractListPage extends StatefulHookConsumerWidget {
  const ContractListPage({super.key});

  @override
  ConsumerState<ContractListPage> createState() => _ContractListPageState();
}

class _ContractListPageState extends ConsumerState<ContractListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData({String? searchText}) {
    Future(() {
      // if (!mounted) return;
      ref.read(contractElectronicProvider.notifier).getListContract();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách hợp đồng',
          style: DSTextStyle.headlineLarge.semiBold().copyWith(
                color: DSColors.backgroundWhite,
              ),
        ),
        iconTheme: IconThemeData(color: DSColors.backgroundWhite),
        centerTitle: true,
        backgroundColor: DSColors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SearchTextFieldWidget(
                      controller: searchController,
                      hintText: 'Tìm kiếm hợp đồng',
                      onChanged: (value) {
                        // deBouncer.value = value;
                        loadData(searchText: value);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          CDNAssets.icons.filter.svg(),
                          SizedBox(width: 3),
                          Text(
                            'Lọc',
                            style: DSTextStyle.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ref.watch(contractElectronicProvider).match(
                  notLoaded: (_) => const SizedBox(),
                  loading: (_) => const ListLoading(),
                  noData: (_) => Center(child: const BaseEmptyState()),
                  failed: (error) => Center(
                    child: BaseEmptyState(
                      title: error.error.message ?? '',
                    ),
                  ),
                  fetched: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () async {
                            bool? result = await context.push(
                              Paths.detailContract,
                              extra: ContractArgumentsDto(
                                id: data.data[index].contractPmxlId,
                                showButtonSign:
                                    data.data[index].showButtonSign ?? false,
                              ),
                            );
                            if(result ?? false){
                              loadData();
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.data[index].contractCode ?? '',
                                          style: DSTextStyle.labelMediumPromient,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CDNAssets.icons.copy.svg(),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  contentCard(
                                    icon: CDNAssets.icons.contractStatus.svg(),
                                    content: data.data[index].stateStr ?? '',
                                    contentStyle: DSTextStyle.bodySmall,
                                  ),
                                  SizedBox(height: 12),
                                  contentCard(
                                    icon: CDNAssets.icons.timeContract.svg(),
                                    content:
                                        'Từ ${data.data[index].startDateStr} đến ${data.data[index].endDateStr}',
                                    contentStyle: DSTextStyle.bodySmall,
                                  ),
                                  SizedBox(height: 12),
                                  contentCard(
                                    icon: CDNAssets.icons.addressContract.svg(),
                                    content:
                                        data.data[index].signGroupName ?? '',
                                    contentStyle: DSTextStyle.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: data.data.length,
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget contentCard({
    required Widget icon,
    String? content,
    TextStyle? contentStyle,
    Function? onTap,
  }) {
    return InkWell(
      onTap: onTap?.call(),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            icon,
            SizedBox(width: 10),
            Expanded(
              child: Text(
                content ?? '',
                style: contentStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
