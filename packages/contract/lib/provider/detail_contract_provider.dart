part of '../../contract.dart';

final detailContractProvider = StateNotifierProvider.autoDispose<DetailContractProvider, DataState<FileContractSignDto, ErrorResponse>>(
      (ref) => DetailContractProvider(ref),
);

class DetailContractProvider extends StateNotifier<DataState<FileContractSignDto, ErrorResponse>> {
  DetailContractProvider(this.ref) : super(NotLoaded<FileContractSignDto>());

  final Ref ref;

  Future<void> viewFileSignContract({int? contractPmxlId, String? description}) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<FileContractSignDto>();
    try {
      final result = await Dependencies().getIt<IOCContactRepository>().viewFileSignContract(
        request: {
          'objectId': contractPmxlId,
          'description': description,
        },
      );
      result.when(
        success: (data) {
          if (data.data != null) {
            state = Fetched(data.data!);
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
  }

  Future<bool> rejectSignContact({
    int? contractId,
    String? description,
    String? reject,
  }) async {
     bool res = false;
    final request = ContractElectronicRequest(
      contractId: contractId,
      description: description,
      type: '2',
      rejectContent: reject,
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
          if (data.otpId  != null) {
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
