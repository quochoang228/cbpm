part of '../../contract.dart';

class SignContractBottomSheet extends StatefulHookConsumerWidget {
  const SignContractBottomSheet(
      {super.key, required this.contractId, required this.otpId});

  final int contractId;
  final int otpId;

  @override
  ConsumerState<SignContractBottomSheet> createState() =>
      _SignContractBottomSheetState();
}

class _SignContractBottomSheetState
    extends ConsumerState<SignContractBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final signatureGlobalKey =
        useMemoized(GlobalKey<SfSignaturePadState>.new, const []);
    final signedState = useState(false);
    final startSigneState = useState(false);
    final showDeleteState = useState(false);

    Future<bool> verifyOtp(otp) async {
      // controller.jumpToPage(1);
      return true;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ký hợp đồng',
          ),
          centerTitle: true,
          backgroundColor: DSColors.backgroundWhite,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            // ------------------ OTP ---------------------------
            wrapperBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ------------------ OTP ---------------------------
                  wrapperBackground(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PinputOtpAutofill(
                          title:
                              "Mã xác thực (OTP) đã được gửi qua Tin nhắn số ",
                          userPhone: "0973526687",
                          onValidator: verifyOtp,
                          onCompleted: (otp, byteSign) async {
                            var result = await ref.read(submitOtpProvider.notifier).submitOTP(
                                  byteSign: byteSign,
                                  otp: otp,
                                  otpId: widget.otpId,
                                  contractId: widget.contractId,
                                  description: "contract",
                                );
                            if(result){
                              showToast("Ký điện tử thành công");
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            } else{
                              showToast("Ký điện tử không thành công");
                            }
                          },
                          countdownText:
                              "Vui lòng chờ {} để nhận lại mã xác thực.",
                          confirmText: "Tiếp tục",
                          notReceiveText: "Bạn chưa nhận được mã?",
                          supportText: "Liên hệ tổng đài",
                          errorText: "Mã OTP không đúng",
                          onSupport: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            wrapperBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 30),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(
                              0xffD3D2D2,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: SfSignaturePad(
                            key: signatureGlobalKey,
                            strokeColor: const Color(0xff0039CD),
                            backgroundColor: Color(0xffF4F4F4),
                            onDrawEnd: () {
                              showDeleteState.value = true;
                              signedState.value = true;
                            },
                            onDrawStart: () {
                              startSigneState.value = true;
                              return false;
                            },
                            minimumStrokeWidth: 1.0,
                            maximumStrokeWidth: 4.0,
                          ),
                        ),
                        Visibility(
                          visible: !startSigneState.value,
                          child: Center(
                            child: Text(
                              "Viết chữ ký tại đây!",
                              style: DSTextStyle.bodySmall.copyWith(
                                color: DSColors.textSubtitle,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: showDeleteState.value,
                          child: Positioned(
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                signatureGlobalKey.currentState?.clear();
                                showDeleteState.value = false;
                                signedState.value = false;
                                startSigneState.value = false;
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding:
                                    const EdgeInsets.only(right: 12, top: 12),
                                child: Icon(
                                  Icons.delete,
                                  color: DSColors.textSubtitle,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  DSButton(
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () async {},
                    label: "Xác nhận ký",
                  ),
                ],
              ),
            ),
          ],
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

  Widget wrapperBackground({child}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            color: DSColors.backgroundWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: child,
        ),
      ),
    );
  }
}
