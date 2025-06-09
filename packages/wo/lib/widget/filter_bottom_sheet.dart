part of '../../wo.dart';

class AppParamFilter {
  String title;
  bool isSelected;
  String code;

  AppParamFilter({
    required this.title,
    this.isSelected = false,
    required this.code,
  });
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<AppParamFilter> appParamTru = [
    AppParamFilter(title: "TT XD B2C", code: "0"),
    AppParamFilter(title: "TT XD B2B", code: "1"),
    AppParamFilter(title: "TT GP&DVKT", code: "2"),
    AppParamFilter(title: "TT VHKT", code: "3"),
    AppParamFilter(title: "TT ĐTHT", code: "4"),
  ];
  List<AppParamFilter> appParamDeadline = [
    AppParamFilter(title: "Quá hạn", code: "0"),
    AppParamFilter(title: "Sắp quá hạn", code: "1"),
    AppParamFilter(title: "Trong hạn", code: "2"),
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
                            'Bộ lọc',
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trụ thực hiện",
                              style: DSTextStyle.labelMedium,
                            ),
                            16.height,
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                children: List.generate(
                                  appParamTru.length,
                                  (index) {
                                    return buildSingleCard(
                                      content: appParamTru[index].title,
                                      code: appParamTru[index].code,
                                      isSelected: appParamTru[index].isSelected,
                                      onTap: () {
                                        setState(() {
                                          appParamTru[index].isSelected =
                                              !appParamTru[index].isSelected;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "Hạn hoàn thành",
                              style: DSTextStyle.labelMedium,
                            ),
                            16.height,
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                children: List.generate(
                                  appParamDeadline.length,
                                  (index) {
                                    return buildSingleCard(
                                      content: appParamDeadline[index].title,
                                      code: appParamDeadline[index].code,
                                      isSelected:
                                          appParamDeadline[index].isSelected,
                                      onTap: () {
                                        setState(() {
                                          appParamDeadline[index].isSelected =
                                              !appParamDeadline[index]
                                                  .isSelected;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SelectFieldWidget(
                              title: "Mã hợp đồng",
                              onTap: () {
                                selectContract();
                              },
                              suffixIcon: CDNAssets.icons.search.svg(
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Mã công trình",
                              onTap: () {
                                selectConstruction();
                              },
                              suffixIcon: CDNAssets.icons.search.svg(
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Trạng thái WO",
                              onTap: () {
                                selectWoStatus();
                              },
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Loại WO",
                              onTap: () {},
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Chi nhánh công trình",
                              onTap: () {},
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Hạng mục",
                              onTap: () {},
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Người thực hiện",
                              onTap: () {},
                              suffixIcon: CDNAssets.icons.search.svg(
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                            SelectFieldWidget(
                              title: "Ngày tạo",
                              onTap: () {},
                              suffixIcon: CDNAssets.icons.calendar1.svg(
                                color: Color(0xFF525252),
                              ),
                            ),
                            16.height,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DSButton(
                      label: "Đặt lại",
                      foregroundColor: DSColors.textBody,
                      borderSide: BorderSide(color: DSColors.backgroundGray),
                      backgroundColor: DSColors.backgroundGray,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: DSButton(
                      label: "Áp dụng",
                      onPressed: () async {
                        showToast("Tính năng này đang được phát triển");
                        Navigator.pop(context);
                      },
                      backgroundColor: DSColors.primary,
                    ),
                  ),
                ],
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
      child: InkWell(
        onTap: onTap,
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
            child: Text(
              content ?? "",
              style: DSTextStyle.bodySmall.copyWith(
                color: isSelected ? DSColors.primary : DSColors.textBody,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectConstruction() {
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
            child: SelectConstructionCodeBottomSheet(),
          ),
        );
      },
    );
  }

  void selectContract() {
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
            child: SelectContractCodeBottomSheet(),
          ),
        );
      },
    );
  }


  void selectWoStatus() {
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
            child: SelectWoStatusBottomSheet(),
          ),
        );
      },
    );
  }
}
