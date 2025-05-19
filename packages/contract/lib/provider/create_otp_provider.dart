part of '../../contract.dart';

final createOtpProvider = StateNotifierProvider.autoDispose<CreateOtpProvider, DataState<OtpDTO, ErrorResponse>>(
      (ref) => CreateOtpProvider(ref),
);

class CreateOtpProvider extends StateNotifier<DataState<OtpDTO, ErrorResponse>> {
  CreateOtpProvider(this.ref) : super(NotLoaded<OtpDTO>());

  final Ref ref;

  Future<bool> createOtp({
    int? contractId,
    String? description,
    String? content,
  }) async {
    bool res = false;
    final request = ContractElectronicRequest(
      contractId: contractId,
      description: description,
      content: content,
    );
    try {
      final result = await Dependencies().getIt<IOCContactRepository>().createOtp(
        request: request.toJson(),
      );
      result.when(
        success: (data) {
          if (data.otpId != null) {
            state = Fetched(data);
          } else {
            state = NoData();
          }
        },
        error: (p0) => state = Failed(ErrorResponse(message: p0.message ?? '')),
        // error: (error) => state = Failed(error),
      );
    } catch (error) {
      state = Failed(ErrorResponse(message: error.toString()));
    }
    return res;
  }
}
