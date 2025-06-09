part of '../../wo.dart';

class SelectConstructionCodeBottomSheet extends StatefulWidget {
  const SelectConstructionCodeBottomSheet({super.key});

  @override
  State<SelectConstructionCodeBottomSheet> createState() =>
      _SelectConstructionCodeBottomSheetState();
}

class _SelectConstructionCodeBottomSheetState
    extends State<SelectConstructionCodeBottomSheet> {
  TextEditingController searchController = TextEditingController();

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
                            'Mã công trình',
                            style: DSTextStyle.headlineLarge.semiBold(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: CDNAssets.icons.iconCloseDialog.svg()),
                      ],
                    ),
                    Divider(),
                    SearchTextFieldWidget(
                      controller: searchController,
                      hintText: 'Tìm kiếm công trình',
                      onChanged: (value) {},
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            5,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "XDDD-3214/HĐMBLĐ-2348/2348293",
                                  style: DSTextStyle.bodyMedium.copyWith(),
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
}
