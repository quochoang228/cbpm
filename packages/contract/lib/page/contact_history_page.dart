part of '../../contract.dart';

class ContactHistoryPage extends StatefulHookConsumerWidget {
  const ContactHistoryPage({
    super.key,
    required this.contractPmxlId,
  });

  final int contractPmxlId;

  @override
  ConsumerState<ContactHistoryPage> createState() => _ContactHistoryPageState();
}

class _ContactHistoryPageState extends ConsumerState<ContactHistoryPage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData({String? searchText}) {
    Future(() {
      // if (!mounted) return;
      ref.read(contactHistoryProvider.notifier).getLogsAction(
          objectId: widget.contractPmxlId, functionCode: "CONTRACT_B2C");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch sử tác động hợp đồng',
          style: DSTextStyle.headlineLarge.semiBold().copyWith(
                color: DSColors.backgroundWhite,
              ),
        ),
        iconTheme: IconThemeData(color: DSColors.backgroundWhite),
        centerTitle: true,
        backgroundColor: DSColors.primary,
      ),
      body: Container(
          color: Colors.white,
          child: CustomizeTabs(
            tabHeader: [
              Text('Lịch sử tác động'),
              Text('Lịch sử cuộc gọi'),
            ],
            tabContents: [
              ref.watch(contactHistoryProvider).match(
                  notLoaded: (_) => const SizedBox(),
                  loading: (_) => const ListLoading(),
                  noData: (_) => const BaseEmptyState(),
                  failed: (error) => BaseEmptyState(
                        title: error.error.message ?? '',
                      ),
                  fetched: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Divider(),
                      ),
                      itemBuilder: (_, index) {
                        var item = data.data.listActionLog?[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item?.actionTypeStr}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.info_outline, color: DSColors.textSubtitle,)
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Thực hiện: ${item?.createdUserStr}',
                                style: DSTextStyle.bodySmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${item?.createdDate != null ? DateTime.fromMillisecondsSinceEpoch(item!.createdDate!).getFormat(pattern: 'dd/MM/yy, HH:mm', locale: 'vi') : ''}',
                                style: DSTextStyle.captionMedium,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: (data.data.listActionLog ?? []).length,
                    );
                  }),
              ref.watch(contactHistoryProvider).match(
                  notLoaded: (_) => const SizedBox(),
                  loading: (_) => const ListLoading(),
                  noData: (_) => const BaseEmptyState(),
                  failed: (error) => BaseEmptyState(
                        title: error.error.message ?? '',
                      ),
                  fetched: (data) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        var item = data.data.listActionLog?[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item?.callType == 1 ? 'Cuộc gọi đi' : 'Cuộc gọi đến',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Người thực hiện: ${item?.actionUserName}',
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${item?.contentLog}',
                                      style: DSTextStyle.bodySmall.copyWith(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    if(item?.newValue != null)...[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Nội dung trước thay đổi: ${item?.newValue}',
                                        style: DSTextStyle.bodySmall.copyWith(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                    if(item?.oldValue != null)...[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Nội dung sau thay đổi: ${item?.oldValue}',
                                        style: DSTextStyle.bodySmall.copyWith(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              item?.callType == 1
                                  ? Icon(
                                Icons.phone_forwarded,
                                color: item?.callStatus == 1 ? Colors.green : Colors.red,
                              )
                                  : Icon(
                                Icons.phone_callback,
                                color: item?.callStatus == 1 ? Colors.green : Colors.red,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: (data.data.listCallLog ?? []).length,
                    );
                  }),
            ],
          )),
    );
  }
}
