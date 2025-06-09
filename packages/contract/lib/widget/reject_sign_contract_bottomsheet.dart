part of '../../contract.dart';

class RejectSignContractBottomSheet extends StatefulHookConsumerWidget {
  const RejectSignContractBottomSheet({super.key,required this.contractId});
  final int contractId;

  @override
  ConsumerState<RejectSignContractBottomSheet> createState() => _RejectSignContractBottomSheetState();
}

class _RejectSignContractBottomSheetState extends ConsumerState<RejectSignContractBottomSheet> {
  final TextEditingController rejectController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
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
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Từ chối ký',
                            style: DSTextStyle.headlineLarge.semiBold(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: rejectController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        hintText: "Nhập lý do từ chối",
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
                        // focusedErrorBorder: InputBorder.none,
                        // floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      maxLines: 5,
                      minLines: 3,
                      validator: (val) {
                        if ((val ?? '').isEmpty) return "Trường bắt buộc nhập";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DSButton(
                      label: "Từ chối",
                      foregroundColor: DSColors.primary,
                      borderSide: BorderSide(color: DSColors.primary),
                      backgroundColor: DSColors.backgroundWhite,
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
                          var result = await ref.read(detailContractProvider.notifier).rejectSignContact(
                            contractId: widget.contractId,
                            description: 'contract',
                            reject: rejectController.text,
                          );
                          if(result){
                            showToast("Từ chối ký thành công");
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          } else{
                            showToast("Từ chối ký không thành công");
                          }

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
      ),
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
