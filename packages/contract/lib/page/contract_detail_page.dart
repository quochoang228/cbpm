part of '../../contract.dart';

class ContractArgumentsDto {
  final int? id;
  final bool showButtonSign;
  final String? description;
  final int? otpId;
  final ContractElectronicDto? contractElectronic;
  final String? partnerName;
  final String? phonePartner;
  final String? code;

  ContractArgumentsDto({
    this.id,
    this.showButtonSign = false,
    this.description,
    this.otpId,
    this.contractElectronic,
    this.partnerName,
    this.phonePartner,
    this.code,
  });
}

class ContractDetailPage extends StatefulHookConsumerWidget {
  const ContractDetailPage({super.key, required this.contractArgumentsDto});

  final ContractArgumentsDto contractArgumentsDto;

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
            contractPmxlId: widget.contractArgumentsDto.id,
            description: 'contract',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pdfGlobalKey = useMemoized(GlobalKey<SfPdfViewerState>.new, const []);

    ref.listen(
      createOtpProvider,
      (previous, next) {
        next.match(
          notLoaded: (p0) {},
          loading: (p0) {
            LoadingDialog.show(context);
          },
          fetched: (p0) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: false,
              backgroundColor: Colors.white,
              builder: (BuildContext context) {
                return SignContractBottomSheet(
                  contractId: widget.contractArgumentsDto.id ?? 0,
                  otpId: p0.data.otpId ?? -1,
                );
              },
            );
          },
          noData: (p0) {},
          failed: (p0) {},
        );
      },
    );

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                context.push(
                  Paths.contactHistory,
                  extra: widget.contractArgumentsDto.id,
                );
              },
              child: Icon(Icons.access_time_filled),
            ),
          ),
        ],
      ),
      body: ref.watch(detailContractProvider).match(
          notLoaded: (_) => const SizedBox(),
          loading: (_) => const ListLoading(),
          noData: (_) => Center(child: const BaseEmptyState()),
          failed: (error) => Center(
                child: BaseEmptyState(
                  title: error.error.message ?? '',
                ),
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
                      'https://apis.congtrinhviettel.com.vn/ioc-mobile/96/static${data.data.filePath ?? ''}',
                      key: pdfGlobalKey,
                    ),
                  ),
                ),
                widget.contractArgumentsDto.showButtonSign
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DSButton(
                                label: "Từ chối",
                                foregroundColor: DSColors.primary,
                                borderSide: BorderSide(color: DSColors.primary),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    enableDrag: false,
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return RejectSignContractBottomSheet(
                                        contractId:
                                            widget.contractArgumentsDto.id ?? 0,
                                      );
                                    },
                                  );
                                },
                                backgroundColor: DSColors.backgroundWhite,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DSButton(
                                label: "Ký khách hàng",
                                onPressed: () async {
                                  ref
                                      .read(createOtpProvider.notifier)
                                      .createOtp(
                                        contractId:
                                            widget.contractArgumentsDto.id,
                                        description: 'contract',
                                        content: "Hợp đồng ký duyệt",
                                      );
                                },
                                backgroundColor: DSColors.primary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            );
          }),
    );
  }

  void showToast(String s) {
    Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
