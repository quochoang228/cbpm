part of '../../../contract.dart';

abstract class IOCContactRepository {
  Future<BaseResult<ListDataResponse<ContractElectronicDto>>> getListContract({
    required Map<String, dynamic> request,
  });
  Future<BaseResult<DataResponse<FileContractSignDto>>> viewFileSignContract({
    required Map<String, dynamic> request,
  });
  Future<BaseResult<MobileCallLogsResponse>> getLogsAction({
    required Map<String, dynamic> request,
  });
  Future<BaseResult<SignDataResponse>> submitOtp({
    required Map<String, dynamic> request,
  });
  Future<BaseResult<OtpDTO>> createOtp({
    required Map<String, dynamic> request,
  });
}

class IOCContactRepositoryImpl extends BaseRepository implements IOCContactRepository {
  IOCContactRepositoryImpl({
    required IOCContractRequestApi api,
    required IOCContractLocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  final IOCContractRequestApi _api;
  final IOCContractLocalStorage _localStorage;

  @override
  Future<BaseResult<ListDataResponse<ContractElectronicDto>>> getListContract({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.getListContactB2B(request: request),
        mapper: (data) {
          return ListDataResponse<ContractElectronicDto>.fromJson(
            data,
                (Object? obj) => ContractElectronicDto.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
  @override
  Future<BaseResult<DataResponse<FileContractSignDto>>> viewFileSignContract({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.viewFileSignContract(request: request),
        mapper: (data) {
          return DataResponse.fromJson(
            data,
                (Object? obj) => FileContractSignDto.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
  @override
  Future<BaseResult<MobileCallLogsResponse>> getLogsAction({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.getLogsAction(request: request),
        mapper: (data) {
          return MobileCallLogsResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
  @override
  Future<BaseResult<SignDataResponse>> submitOtp({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.submitOtp(request: request),
        mapper: (data) {
          return SignDataResponse.fromJson(data["data"] as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
  @override
  Future<BaseResult<OtpDTO>> createOtp({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.createOtp(request: request),
        mapper: (data) {
          return OtpDTO.fromJson(data["data"] as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
