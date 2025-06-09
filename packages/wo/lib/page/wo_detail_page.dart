part of '../../wo.dart';

class WoDetailPage extends StatefulHookConsumerWidget {
  const WoDetailPage({
    super.key,
    required this.woHcId,
  });

  final int woHcId;

  @override
  ConsumerState<WoDetailPage> createState() => _WoDetailPageState();
}

class _WoDetailPageState extends ConsumerState<WoDetailPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController transferDateController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData({String? searchText}) {
    Future(() async {
      await ref.read(detailWoProvider.notifier).getWoDetail(widget.woHcId);
    });
  }

  List<FileDataDto> listImageProcess = [];
  List<ImageUpdate> listImageSelected = [];
  List<ImageUpdate> listFileKsCLDV = [];

  @override
  Widget build(BuildContext context) {
    ref.listen(
      uploadImageProvider,
      (previous, next) {
        next.match(
          notLoaded: (p0) {},
          loading: (p0) {
            LoadingDialog.show(context);
          },
          fetched: (p0) {
            LoadingDialog.dismiss(context);
            setState(() {
              listImageProcess.addAll(p0.data);
            });
            showToast("Tải ảnh lên thành công");
          },
          noData: (p0) {},
          failed: (p0) {},
        );
      },
    );

    ref.listen(
      detailWoProvider,
      (previous, next) {
        next.match(
          notLoaded: (p0) {},
          loading: (p0) {
            LoadingDialog.show(context);
          },
          fetched: (p0) {
            LoadingDialog.dismiss(context);
            setState(() {
              listFileKsCLDV.addAll((p0.data.listFileKsCLDV ?? [])
                  .map((e) => ImageUpdate(
                        name: e.name ?? '',
                        filePath: e.filePath ?? '',
                        base64String: e.base64String ?? '',
                        extension: e.extension ?? '',
                      ))
                  .toList());
            });
          },
          noData: (p0) {},
          failed: (p0) {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết WO',
          style: DSTextStyle.headlineLarge.semiBold().copyWith(
                color: DSColors.backgroundWhite,
              ),
        ),
        iconTheme: IconThemeData(color: DSColors.backgroundWhite),
        centerTitle: true,
        backgroundColor: DSColors.primary,
      ),
      body: ref.watch(detailWoProvider).match(
            notLoaded: (_) => const SizedBox(),
            loading: (_) => const ListLoading(),
            noData: (_) => Center(child: const BaseEmptyState()),
            failed: (error) => Center(
              child: BaseEmptyState(
                title: error.error.message ?? '',
              ),
            ),
            fetched: (data) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: DSColors.backgroundWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.data.woName ?? '',
                                    style: DSTextStyle.headlineMedium,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  data.data.stateName ?? '',
                                  style: DSTextStyle.labelMedium.copyWith(
                                      // color: DSColors.primary,
                                      ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Mã HĐ: ${data.data.woCode ?? ''}",
                              style: DSTextStyle.captionLarge.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            Divider(),
                            contentCard(
                              title: "Công trình:",
                              content: data.data.constructionCode ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Hạng mục:",
                              content: data.data.taskPlanNames ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Công việc làm hồ sơ:",
                              content: data.data.taskPlanNames ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Giá trị:",
                              content: "${data.data.moneyValue ?? 0} VNĐ",
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Người thực hiện:",
                              content: data.data.ftName ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Ngày tạo:",
                              content: data.data.createDateString ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Ngày hoàn thành:",
                              content: data.data.finishDateString ?? '',
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: DSColors.backgroundWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kết quả thực hiện",
                              style: DSTextStyle.headlineMedium,
                            ),
                            Divider(),
                            contentCard(
                              title: "Công việc:",
                              content: "Hồ sơ hoàn công",
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            contentCard(
                              title: "Trạng thái:",
                              content: "Đã hoàn thành",
                              titleStyle: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                            Divider(),
                            SelectDateTimeWidget(
                              title: "Ngày bàn giao đưa vào sử dụng",
                              controller: transferDateController,
                              isRequired: true,
                              tapOnly: true,
                              validator: (val) {
                                if ((val ?? '').isEmpty) {
                                  return "Trường bắt buộc nhập";
                                }
                                return null;
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                ).then((value) {
                                  if (value != null) {
                                    transferDateController.text = value
                                        .toLocal()
                                        .toString()
                                        .split(' ')[0];
                                  }
                                });
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Ảnh thực hiện",
                                    style: DSTextStyle.labelMedium,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 80,
                              child: ListView.separated(
                                itemCount: listImageSelected.length + 1,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(right: 16),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  if (index == listImageSelected.length) {
                                    return InkWell(
                                      onTap: () {
                                        onTakePicture();
                                      },
                                      child: CDNAssets.icons.uploadImage.svg(),
                                    );
                                  }
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        padding: const EdgeInsets.only(
                                          top: 4,
                                          right: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: DSColors.borderDefault,
                                            ),
                                            child: Image.memory(
                                              Base64Decoder().convert(
                                                  listImageSelected[index]
                                                          .base64String ??
                                                      ''),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {},
                                          child:
                                              CDNAssets.icons.closeCircle.svg(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "File khảo sát chất lượng khách",
                                  style: DSTextStyle.labelMedium,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Vui lòng upload ảnh đúng thứ tự",
                              style: DSTextStyle.captionMedium,
                            ),
                            SizedBox(height: 12),
                            CustomMultiFilePicker(
                              initFiles: listFileKsCLDV,
                              onChanged: (List<File> files) async {
                                for (var file in files) {
                                  final extension = p.extension(file.path);
                                  final fileName = p.basename(file.path);
                                  final bytes = file.readAsBytesSync();
                                  List<ImageUpdate> listFileSelected = [];
                                  listFileSelected.add(
                                    ImageUpdate(
                                      name: fileName,
                                      filePath: file.path,
                                      extension: extension,
                                      base64String: base64Encode(bytes),
                                    ),
                                  );
                                }
                                var result = await ref
                                    .read(uploadImageProvider.notifier)
                                    .uploadFile(
                                      files: listFileKsCLDV,
                                      woHcId: widget.woHcId,
                                    );
                                if (result == true) {
                                  loadData();
                                  bool? res = await context.push(
                                    Paths.customerFeedbackSurveyPage,
                                    extra: data.data,
                                  );
                                  if (res ?? false) {
                                    loadData();
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 12)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _renderAction(context, data.data),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _renderAction(BuildContext context, WoDetail wo) {
    switch (wo.stateName) {
      case 'Chờ FT tiếp nhận':
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Từ chối",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onRejectWo();
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
                        woHcId: widget.woHcId,
                      )
                      .then((value) {
                    if (value) {
                      showToast("Tiếp nhận thành công");
                      Navigator.of(context).pop(true);
                    }
                  });
                },
                backgroundColor: DSColors.primary,
              ),
            ),
          ],
        );
      case 'FT đã tiếp nhận':
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Đề xuất gia hạn",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onExtendWo();
                },
                backgroundColor: DSColors.backgroundWhite,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DSButton(
                label: "Gửi duyệt",
                onPressed: () async {
                  if (listImageSelected.isEmpty) {
                    showToast('Bạn chưa tải lên ảnh thực hiện');
                  }
                  if (listFileKsCLDV.isEmpty) {
                    showToast(
                        'Bạn chưa tải lên file khảo sát chất lượng khách hàng');
                  } else {
                    await completeWo(
                      woHcId: wo.woHcId,
                      ftId: wo.ftId,
                      images: listImageSelected,
                    );
                  }
                },
                backgroundColor: DSColors.primary,
              ),
            ),
          ],
        );
      case 'Đang thực hiện':
        return Row(
          children: [
            Expanded(
              child: DSButton(
                label: "Đề xuất gia hạn",
                foregroundColor: DSColors.primary,
                borderSide: BorderSide(color: DSColors.primary),
                onPressed: () {
                  onExtendWo();
                },
                backgroundColor: DSColors.backgroundWhite,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DSButton(
                label: "Gửi duyệt",
                onPressed: () async {
                  if (listImageSelected.isEmpty) {
                    showToast('Bạn chưa tải lên ảnh thực hiện');
                  }
                  if (listFileKsCLDV.isEmpty) {
                    showToast(
                        'Bạn chưa tải lên file khảo sát chất lượng khách hàng');
                  } else {
                    await completeWo(
                      woHcId: wo.woHcId,
                      ftId: wo.ftId,
                      images: listImageSelected,
                    );
                  }
                },
                backgroundColor: DSColors.primary,
              ),
            ),
          ],
        );
      case 'Hoàn thành':
        return Container();
      default:
        return Container();
    }
  }

  Widget contentCard({
    required String title,
    String? content,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title ?? '',
                style: titleStyle ?? DSTextStyle.bodySmall,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Text(
                content ?? '',
                style: contentStyle ?? DSTextStyle.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTakePicture() async {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: bottom),
          height: MediaQuery.of(context).size.height * 0.15,
          width: double.infinity,
          child: UploadImageBottomSheet(
            onPickImage: (file) async {
              final extension = p.extension(file.path);
              final fileName = p.basename(file.path);
              final bytes = file.readAsBytesSync();
              setState(() {
                listImageSelected.add(ImageUpdate(
                  name: fileName,
                  filePath: file.path,
                  base64String: base64Encode(bytes),
                  extension: '$extension',
                ));
              });
              // await ref.read(uploadImageProvider.notifier).uploadFile(file: file);
            },
            onTakeImage: (file) async {
              final extension = p.extension(file.path);
              final fileName = p.basename(file.path);
              final bytes = file.readAsBytesSync();
              setState(() {
                listImageSelected.add(ImageUpdate(
                  name: fileName,
                  filePath: file.path,
                  base64String: base64Encode(bytes),
                  extension: '$extension',
                ));
              });
              // await ref.read(uploadImageProvider.notifier).uploadFile(file: file);
            },
          ),
        );
      },
    );
  }

  void onRejectWo() async {
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
                      woHcId: widget.woHcId,
                      isReject: true,
                      reasonReject: reason,
                    )
                    .then((value) {
                  if (value) {
                    showToast("Từ chối thành công");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  void onExtendWo() async {
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
                      woHcId: widget.woHcId,
                      endDate: date,
                      reason: reason,
                    )
                    .then((value) {
                  if (value) {
                    showToast("Gia hạn thành công");
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> completeWo(
      {int? woHcId, int? ftId, List<ImageUpdate>? images}) async {
    ref
        .read(updateWoProvider.notifier)
        .actionCompleteWo(woHcId: woHcId, listImagePush: images)
        .then((value) {
      if (value) {
        showToast("Gửi duyệt thành công");
        Navigator.of(context).pop();
        Navigator.of(context).pop(true);
      }
    });
  }
}
