import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ds/ds.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class PinputOtpAutofill extends StatefulHookConsumerWidget {
  const PinputOtpAutofill({
    super.key,
    required this.title,
    required this.userPhone,
    required this.onValidator,
    required this.countdownText,
    required this.confirmText,
    required this.notReceiveText,
    required this.supportText,
    required this.onSupport,
    required this.onCompleted,
    required this.errorText,
    this.otpLength = 6,
  });

  final String title;
  final String userPhone;
  final Function onValidator;
  final Function onSupport;
  final Function(String otp, Uint8List byteSign) onCompleted;
  final String countdownText;
  final String confirmText;
  final String notReceiveText;
  final String supportText;
  final String errorText;
  final int otpLength;

  @override
  ConsumerState<PinputOtpAutofill> createState() => _PinputOtpAutofillState();
}

class _PinputOtpAutofillState extends ConsumerState<PinputOtpAutofill>
    with WidgetsBindingObserver {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late Timer timer;
  int timeValid = 120;
  bool hasRecipe = true;
  bool loading = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    setState(() {
      timeValid = 120;
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

  @override
  Widget build(BuildContext context) {
    final signatureGlobalKey =
        useMemoized(GlobalKey<SfSignaturePadState>.new, const []);
    final signedState = useState(false);
    final startSigneState = useState(false);
    final showDeleteState = useState(false);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    List<String> countdownText = widget.countdownText.split("{}");

    final defaultPinTheme = PinTheme(
        width: 48,
        height: 48,
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF7F8F9),
          border: Border.all(
            color: Color(0xFFF1F2F4),
          ),
        ));

    return SizedBox(
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 30,
              ),
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
                          padding: const EdgeInsets.only(right: 12, top: 12),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title,
                        style: DSTextStyle.bodySmall.copyWith(
                          color: Color(0xff82878B),
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: widget.userPhone,
                        style: DSTextStyle.headlineMedium.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  length: widget.otpLength,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    return (hasRecipe) ? null : widget.errorText;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    if (pin.length == widget.otpLength && !loading) {
                      Future.delayed(const Duration(milliseconds: 100), () async {
                        Navigator.pop(context);
                        var signImage = await signatureGlobalKey.currentState?.toImage();
                        var byteData = await signImage?.toByteData(format: ImageByteFormat.png);
                        widget.onCompleted(pin, byteData!.buffer.asUint8List());
                      });
                    }
                  },
                  onChanged: (value) async {
                    setState(() {
                      hasRecipe = true;
                      loading = true;
                    });
                    if (value.length == widget.otpLength) {
                      bool check = await widget.onValidator(value);
                      setState(() {
                        hasRecipe = check;
                        loading = false;
                      });
                      formKey.currentState!.validate();
                    }
                  },
                  cursor: Container(
                    width: 1,
                    height: 22,
                    color: DSColors.backgroundBlack,
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: DSColors.backgroundWhite,
                      border: Border.all(
                        color: Color(0xFFE81D2B),
                      ),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      border: Border.all(
                        color: Color(0xFFE81D2B),
                      ),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme,
                  errorTextStyle: DSTextStyle.bodySmall.copyWith(
                    color: Color(0xFFE81D2B),
                  ),
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DSTextStyle.bodySmall.copyWith(
                      color: Color(0xff82878B),
                      height: 1.3,
                    ),
                    children: [
                      TextSpan(
                        text: countdownText.first,
                      ),
                      TextSpan(
                        text: '${timeValid.toString()}s',
                      ),
                      TextSpan(
                        text: countdownText.last,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (timeValid <= 100) // after 30s show the not receive text
                  InkWell(
                    onTap: () {
                      widget.onSupport();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.support_agent,
                          color: DSColors.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Liên hệ tổng đài",
                          style: DSTextStyle.labelMedium.copyWith(
                            color: DSColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 40),
                DSButton(
                  borderRadius: BorderRadius.circular(10),
                  isLoading: loading,
                  onPressed: () async {
                    focusNode.unfocus();
                    if (formKey.currentState!.validate()) {
                      // await widget.onValidator(pinController.text);
                      var signImage = await signatureGlobalKey.currentState?.toImage();
                      var byteData = await signImage?.toByteData(format: ImageByteFormat.png);
                      widget.onCompleted(pinController.text, byteData!.buffer.asUint8List());
                    }
                  },
                  label: widget.confirmText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
