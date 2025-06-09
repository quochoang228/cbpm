part of '../../wo.dart';

class SelectWoStatusBottomSheet extends StatefulWidget {
  const SelectWoStatusBottomSheet({super.key});

  @override
  State<SelectWoStatusBottomSheet> createState() =>
      _SelectWoStatusBottomSheetBottomSheetState();
}

class _SelectWoStatusBottomSheetBottomSheetState
    extends State<SelectWoStatusBottomSheet> {
  TextEditingController searchController = TextEditingController();

  List<AppParamFilter> statusSelected = [
    AppParamFilter(title: "CD đã tiếp nhận", code: "0"),
    AppParamFilter(title: "Chờ CD tiếp nhận", code: "1"),
    AppParamFilter(title: "Chờ FT tiếp nhận", code: "2"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Trạng thái WO',
                            style: DSTextStyle.headlineLarge.semiBold(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CDNAssets.icons.iconCloseDialog.svg(),
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      children: [
                        Row (
                          children: [
                            Expanded(
                              child: Text(
                                "Trạng thái được chọn",
                                style: DSTextStyle.labelMedium.copyWith(
                                  color: DSColors.textBody,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Thiết lập lại",
                                style: DSTextStyle.labelSmall.copyWith(
                                  color: DSColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 16.height,
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            children: List.generate(
                              statusSelected.length,
                              (index) {
                                return buildSingleCard(
                                  content: statusSelected[index].title,
                                  code: statusSelected[index].code,
                                  isSelected: statusSelected[index].isSelected,
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    16.height,
                    SearchTextFieldWidget(
                      controller: searchController,
                      hintText: 'Tìm trạng thái',
                      onChanged: (value) {},
                    ),
                    16.height,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            15,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                            value: true,
                                            onChanged: (val) {
                                              // widget.onSelect?.call(item, index);
                                            },
                                            activeColor: DSColors.primary,
                                          ),
                                        ),
                                        5.width,
                                        Text(
                                          "XDDD-3214/HĐMBLĐ-2348/2348293",
                                          style: DSTextStyle.bodyMedium.copyWith(),
                                        ),
                                      ],
                                    ),
                                    16.height,
                                    Divider(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildSingleCard({
    String? content,
    String? code,
    bool isSelected = false,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color:
              isSelected ? DSColors.primarySurface : DSColors.borderDisable,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 7,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content ?? "",
                style: DSTextStyle.bodySmall.copyWith(
                  color: isSelected ? DSColors.primary : DSColors.textSubtitle,
                ),
              ),
              2.width,
              InkWell(
                child: Icon(Icons.close_outlined, color: DSColors.textSubtitle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
