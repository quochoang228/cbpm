part of '../../wo.dart';

class SelectContractCodeBottomSheet extends StatefulWidget {
  const SelectContractCodeBottomSheet({super.key});

  @override
  State<SelectContractCodeBottomSheet> createState() =>
      _SelectContractCodeBottomSheetState();
}

class _SelectContractCodeBottomSheetState
    extends State<SelectContractCodeBottomSheet> {
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
                            'Mã hợp đồng',
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
                      hintText: 'Tìm kiếm hợp đồng',
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
