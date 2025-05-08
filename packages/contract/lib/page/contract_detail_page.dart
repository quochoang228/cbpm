part of '../../contract.dart';

class ContractDetailPage extends StatefulHookConsumerWidget {
  const ContractDetailPage({super.key, required this.contractPmxlId});

  final int contractPmxlId;

  @override
  ConsumerState<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends ConsumerState<ContractDetailPage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData({String? searchText}) {
    Future(() {
      ref.read(detailContractProvider.notifier).viewFileSignContract(
            contractPmxlId: widget.contractPmxlId,
            description: 'contract',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pdfGlobalKey = useMemoized(GlobalKey<SfPdfViewerState>.new, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết hợp đồng',
          style: DSTextStyle.headlineLarge.semiBold().copyWith(
                color: DSColors.backgroundWhite,
              ),
        ),
        iconTheme: IconThemeData(color: DSColors.backgroundWhite),
        centerTitle: true,
        backgroundColor: DSColors.primary,
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(Icons.access_time_filled),
          ),
        ],
      ),
      body: ref.watch(detailContractProvider).match(
          notLoaded: (_) => const SizedBox(),
          loading: (_) => const ListLoading(),
          noData: (_) => const BaseEmptyState(),
          failed: (error) => BaseEmptyState(
                title: error.error.message ?? '',
              ),
          fetched: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: SfPdfViewer.network(
                      'https://apis.congtrinhviettel.com.vn/ioc-mobile/static${data.data.filePath ?? ''}',
                      key: pdfGlobalKey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DSButton(
                          label: "Từ chối",
                          textStyle: TextStyle(color: Colors.black),
                          borderSide: BorderSide(color: Colors.red),
                          onPressed: () {},
                          backgroundColor: DSColors.backgroundWhite,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: DSButton(
                          label: "Ký khách hàng",
                          onPressed: () {},
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
