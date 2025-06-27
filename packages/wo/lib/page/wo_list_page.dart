part of '../../wo.dart';

class WoListPage extends StatefulHookConsumerWidget {
  const WoListPage({super.key});

  @override
  ConsumerState<WoListPage> createState() => _WoListPageState();
}

class _WoListPageState extends ConsumerState<WoListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData({String? searchText}) {
    Future(() {
      ref.read(listWoProvider.notifier).getListWo(WoRequest(
            keySearch: searchText,
            page: 0,
            pageSize: 2000,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách WO',
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
                    // child: Container(),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      onFilter();
                    },
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
            child: ref.watch(listWoProvider).match(
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
                              Paths.woDetailPage,
                              extra: data.data[index].woHCId,
                            );
                            if (result ?? false) {
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
                                          data.data[index].woName ?? '',
                                          style: DSTextStyle.headlineSmall,
                                        ),
                                      ),
                                      const Spacer(),
                                      CDNAssets.icons.timeContract.svg(
                                        color: DSColors.primary,
                                        width: 24,
                                        height: 24,
                                      ),
                                      Text(
                                        "Quá hạn",
                                        style: DSTextStyle.labelMedium.copyWith(
                                          color: DSColors.primary,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Mã HĐ: ${data.data[index].contractCode ?? ''}",
                                    style: DSTextStyle.captionMedium.copyWith(
                                      color: DSColors.textSubtitle,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 92,
                                        height: 128,
                                        decoration: BoxDecoration(
                                          color: DSColors.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "19",
                                                style: DSTextStyle.headlineLarge
                                                    .copyWith(
                                                        color: DSColors
                                                            .borderFocus),
                                              ),
                                              Text(
                                                "Tháng 5",
                                                style: DSTextStyle.headlineSmall
                                                    .copyWith(
                                                        color: DSColors
                                                            .borderFocus),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            contentCard(
                                              icon: CDNAssets
                                                  .icons.contractStatus
                                                  .svg(
                                                width: 16,
                                                height: 16,
                                              ),
                                              content: data.data[index]
                                                      .woStateName ??
                                                  '',
                                            ),
                                            contentCard(
                                              icon:
                                                  CDNAssets.icons.calendar1.svg(
                                                width: 16,
                                                height: 16,
                                              ),
                                              content: data.data[index]
                                                      .taskPlanNames ??
                                                  '',
                                            ),
                                            contentCard(
                                                icon: CDNAssets
                                                    .icons.addressContract
                                                    .svg(
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                content:
                                                    "${data.data[index].moneyValue ?? ''}đ"),
                                            contentCard(
                                              icon: CDNAssets.icons.time.svg(
                                                width: 16,
                                                height: 16,
                                              ),
                                              content: data.data[index]
                                                      .createdUserFullName ??
                                                  '',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  _renderAction(data.data[index]),
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
      child: Padding(
        padding: const EdgeInsets.all(6.0),
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
      ),
    );
  }

  Widget _renderAction(WoResponse wo) {
    switch (wo.woStateName) {
      case 'Chờ FT tiếp nhận':
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Từ chối",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onRejectWo(wo.woHCId);
                },
                backgroundColor: DSColors.backgroundWhite,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DSButton(
                label: "Tiếp nhận",
                onPressed: () async {
                  ref
                      .read(updateWoProvider.notifier)
                      .acceptWohcAssign(
                        woHcId: wo.woHCId,
                      )
                      .then((value) {
                    if (value) {
                      showToast("Tiếp nhận thành công");
                      loadData();
                    }
                  });
                },
                backgroundColor: DSColors.primary,
              ),
            ),
          ],
        );
      case 'Chờ CD tiếp nhận':
        if (wo.woTypeCode == 'DX_HH') {
          return Row(
            children: [
              Expanded(
                child: DSButton(
                  label: "Tiếp nhận",
                  onPressed: () async {
                    ref
                        .read(updateWoProvider.notifier)
                        .acceptWohcAssign(
                          woHcId: wo.woHCId,
                        )
                        .then((value) {
                      if (value) {
                        showToast("Tiếp nhận thành công");
                        loadData();
                      }
                    });
                  },
                  backgroundColor: DSColors.primary,
                ),
              ),
            ],
          );
        }
        return SizedBox();
      case 'FT đã tiếp nhận':
        if (wo.hideExtendButton) {
          return SizedBox();
        }
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Đề xuất ra hạn",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onExtendWo(wo.woHCId);
                },
                backgroundColor: DSColors.backgroundWhite,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DSButton(
                label: "Thực hiện",
                onPressed: () async {
                  ref.read(updateWoProvider.notifier).processWohc(
                    woHcId: wo.woHCId,
                    listFileKsCLDV: [],
                  ).then((value) {
                    if (value) {
                      showToast("Thực hiện thành công");
                      loadData();
                    }
                  });
                },
                backgroundColor: DSColors.primary,
              ),
            ),
          ],
        );
      case 'Đang thực hiện':
        if (wo.hideExtendButton) {
          return SizedBox();
        }
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Đề xuất ra hạn",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onExtendWo(wo.woHCId);
                },
                backgroundColor: DSColors.backgroundWhite,
              ),
            ),
          ],
        );
      case 'Hoàn thành':
        return SizedBox();
      default:
        return SizedBox();
    }
  }

  void onExtendWo(int woHcId) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: ProposedExtensionBottomSheet(
              onAccept: (reason, date) {
                ref
                    .read(updateWoProvider.notifier)
                    .extendWohc(
                      woHcId: woHcId,
                      endDate: date,
                      reason: reason,
                    )
                    .then((value) {
                  if (value) {
                    showToast("Gia hạn thành công");
                    loadData();
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  void onRejectWo(int woHcId) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: RejectWoBottomSheet(
              onAccept: (reason) {
                ref
                    .read(updateWoProvider.notifier)
                    .acceptWohcAssign(
                      woHcId: woHcId,
                      isReject: true,
                      reasonReject: reason,
                    )
                    .then((value) {
                  if (value) {
                    showToast("Từ chối thành công");
                    Navigator.of(context).pop();
                    loadData();
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  void onFilter() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: FilterBottomSheet(),
          ),
        );
      },
    );
  }
}
