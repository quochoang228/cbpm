part of '../../wo.dart';

class RejectWoBottomSheet extends StatefulWidget {
  final Function(String reason)? onAccept;

  const RejectWoBottomSheet({
    super.key,
    this.onAccept,
  });

  @override
  State<RejectWoBottomSheet> createState() => _RejectWoBottomSheetState();
}

class _RejectWoBottomSheetState extends State<RejectWoBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController rejectController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
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
                              'Xác nhận từ chối',
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
                      const SizedBox(height: 16),
                      Text(
                        "Bạn có muốn từ chối WO này",
                        style: DSTextStyle.bodySmall,
                      ),
                      const Gap(16),
                      TextFormField(
                        controller: rejectController,
                        decoration: InputDecoration(
                          hintText: 'Lý do từ chối',
                          hintStyle: DSTextStyle.bodyLarge
                              .copyWith(color: DSColors.textPlaceholder),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF4F5F7),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF4F5F7),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF4F5F7),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DSColors.primary,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          errorStyle: DSTextStyle.captionLarge
                              .copyWith(color: DSColors.error),
                        ),
                        maxLines: 3,
                        validator: (val) {
                          if ((val ?? '').isEmpty) {
                            return "Trường bắt buộc nhập";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DSButton(
                        label: "Hủy bỏ",
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
                        label: "Xác nhận",
                        onPressed: () async {
                          _formKey.currentState?.save();
                          if (_formKey.currentState?.validate() ?? false) {
                            widget.onAccept?.call(rejectController.text);
                          } else {
                            print("validation failed");
                          }
                        },
                        backgroundColor: DSColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
