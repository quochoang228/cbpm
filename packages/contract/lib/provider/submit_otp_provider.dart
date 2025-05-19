part of '../../contract.dart';

final submitOtpProvider = StateNotifierProvider.autoDispose<SubmitOtpProvider, DataState<OtpDTO, ErrorResponse>>(
      (ref) => SubmitOtpProvider(ref),
);

class SubmitOtpProvider extends StateNotifier<DataState<OtpDTO, ErrorResponse>> {
  SubmitOtpProvider(this.ref) : super(NotLoaded<OtpDTO>());

  final Ref ref;

  Future<bool> submitOTP({
    int? contractId,
    int? otpId,
    String? otp,
    String? description,
    required Uint8List byteSign,
  }) async {
    bool res = false;
    final request = ContractElectronicRequest(
      contractId: contractId,
      description: description,
      type: '1',
      otpId: otpId,
      otpCode: otp,
      imagePath: byteSign,
    );
    try {
      final result = await Dependencies().getIt<IOCContactRepository>().submitOtp(
        request: request.toJson(),
      );
      result.when(
        success: (data) {
          if (data.result  ?? false) {
            res = true;
          } else {
            res = false;
          }
        },
      );
    } catch (error) {
      res = false;
    }
    return res;
  }
}
