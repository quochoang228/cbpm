part of '../../../contract.dart';

abstract class IOCContractRequestApi {
  Future<Response> getListContactB2B({
    required Map<String, dynamic> request,
  });
  Future<Response> viewFileSignContract({
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
}
