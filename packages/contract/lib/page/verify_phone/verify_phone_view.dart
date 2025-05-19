import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pinput_otp_autofill.dart';

class VerifyPhoneRegisterView extends StatefulHookConsumerWidget {
  const VerifyPhoneRegisterView({
    super.key,
    required this.phoneNumber,
    required this.onCompleted,
    required this.onResentOtp,
    this.orderCode,
  });

  final String phoneNumber;
  final String? orderCode;
  final Function onCompleted;
  final Function onResentOtp;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyPhoneRegisterViewState();
}

class _VerifyPhoneRegisterViewState
    extends ConsumerState<VerifyPhoneRegisterView> {
  late String phoneNumber;

  @override
  void initState() {
    phoneNumber = widget.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PinputOtpAutofill(
      title: "Vui lòng chờ {} để nhận lại mã xác thực",
      userPhone: phoneNumber,
      orderCode: widget.orderCode,
      onCompleted: (String otp) {
      },
      countdownText: "1",
      confirmText: "Xác nhận",
      notReceiveText: "Khách hàng chưa nhận được mã?",
      supportText: "Gửi lại OTP",
      errorText: "",
      onSupport: () {
        widget.onResentOtp.call();
      },
    );
  }
}
