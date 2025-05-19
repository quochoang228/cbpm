part of '../../../contract.dart';

abstract class IOCContractRequestApi {
  Future<Response> getListContactB2B({
    required Map<String, dynamic> request,
  });
  Future<Response> viewFileSignContract({
    required Map<String, dynamic> request,
  });
  Future<Response> getLogsAction({
    required Map<String, dynamic> request,
  });
  Future<Response> submitOtp({
    required Map<String, dynamic> request,
  });
  Future<Response> createOtp({
    required Map<String, dynamic> request,
  });
}

class IOCContractRequestApiImpl implements IOCContractRequestApi {
  final ApiGateway _apiGateway;

  IOCContractRequestApiImpl({
    required ApiGateway apiGateway,
  }) : _apiGateway = apiGateway;

  @override
  Future<Response> getListContactB2B({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/contract/getContractForElectricSignature',
      data: request,
    );
  }

  @override
  Future<Response> viewFileSignContract({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/common/viewFileSignContract',
      data: request,
    );
  }

  @override
  Future<Response> getLogsAction({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/kpiLog/get-all-logs-action',
      data: request,
    );
  }

  @override
  Future<Response> submitOtp({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/otp/submit',
      data: request,
    );
  }

  @override
  Future<Response> createOtp({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/otp/create',
      data: request,
    );
  }
}
