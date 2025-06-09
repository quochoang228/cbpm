import 'dart:async';
import 'package:ds/ds.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';

class PinputOtpAutofill extends StatefulHookConsumerWidget {
  const PinputOtpAutofill({
    super.key,
    required this.title,
    required this.userPhone,
    required this.countdownText,
    required this.confirmText,
    required this.notReceiveText,
    required this.supportText,
    required this.onSupport,
    required this.onCompleted,
    required this.errorText,
    this.otpLength = 6,
    this.orderCode,
  });

  final String title;
  final String userPhone;
  final Function onSupport;
  final Function onCompleted;
  final String countdownText;
  final String confirmText;
  final String notReceiveText;
  final String supportText;
  final String errorText;
  final int otpLength;
  final String? orderCode;

  @override
  ConsumerState createState() => PinputOtpAutofillState();
}

class PinputOtpAutofillState extends ConsumerState<PinputOtpAutofill>
    with WidgetsBindingObserver {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late Timer timer;
  int timeValid = 120;

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    setState(() {
      timeValid = 300;
    });

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted) {
          if (timeValid == 0) {
            setState(() {
              timer.cancel();
            });
          } else if (timeValid > 0) {
            setState(() {
              timeValid--;
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      timeValid = timeValid--;
    }
  }

  Future<void> verifyOtp(otp) async {}

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    List<String> titleTexts = widget.title.split("{}");

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
        border: Border.all(color: Colors.grey),
      ),
    );

    // var state = ref.watch(verifyPhoneProvider);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "Mã xác thực (OTP) đã được gửi qua Tin nhắn số",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF404040),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "0986578865",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF404040),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    length: widget.otpLength,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {
                      // if (ref.watch(verifyPhoneProvider).loadDataStatus ==
                      //     LoadStatus.failure) {
                      //   return "Mã OTP không đúng. Vui lòng nhập lại";
                      // }
                      return null;
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) async {
                      // await verifyOtp(pin);
                      // formKey.currentState!.validate();
                      // if (pin.length == widget.otpLength &&
                      //     ref.watch(verifyPhoneProvider).loadDataStatus ==
                      //         LoadStatus.success) {
                      //   Future.delayed(const Duration(milliseconds: 100), () {
                      //     Navigator.pop(context);
                      //     widget.onCompleted(pin);
                      //   });
                      // }
                    },
                    cursor: Container(
                      width: 1,
                      height: 22,
                      color: Colors.black,
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme,
                    errorTextStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  const SizedBox(height: 64),
                  timeValid > 0
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF404040),
                            ),
                            children: [
                              TextSpan(
                                text: titleTexts.first,
                              ),
                              TextSpan(
                                text: '${timeValid.toString()}s',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF404040),
                                ),
                              ),
                              TextSpan(
                                text: titleTexts.last,
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.notReceiveText,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF404040),
                                ),
                              ),
                              const SizedBox(width: 4),
                              DSButton(
                                label: widget.supportText,
                                onPressed: () {
                                  widget.onSupport();
                                  startTimer();
                                },
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 16),
                  // after 30s show the not receive textColor
                  if (timeValid <= 90)
                    DSButton(
                      label: "Liên hệ tổng đài",
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: SafeArea(
              child: DSButton(
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  focusNode.unfocus();
                  formKey.currentState!.validate();
                },
                label: widget.confirmText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
