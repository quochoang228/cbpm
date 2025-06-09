part of '../../../wo.dart';

abstract class IOCWoApi {
  Future<Response> getListWo({
    required Map<String, dynamic> request,
  });

  Future<Response> getWoDetail({
    required int woHcId,
  });

  Future<Response> getProcessDetail({
    required int taskPlanId,
    required int employeeCode,
  });

  Future<Response> acceptWohcAssign({
    required Map<String, dynamic> request,
  });

  Future<Response> extendWohc({
    required Map<String, dynamic> request,
  });

  Future<Response> processWohc({
    required Map<String, dynamic> request,
  });

  Future<Response> actionCompleteWo({
    required Map<String, dynamic> request,
  });

  Future<Response> uploadFile({
    required FormData formData,
  });

  Future<Response> saveSurveyCLDV({
    required Map<String, dynamic> request,
  });
}

class IOCWoApiImpl implements IOCWoApi {
  final ApiGateway _apiGateway;

  IOCWoApiImpl({
    required ApiGateway apiGateway,
  }) : _apiGateway = apiGateway;

  @override
  Future<Response> getListWo({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/search-wohc',
      data: request,
    );
  }

  @override
  Future<Response> getWoDetail({
    required int woHcId,
  }) {
    return _apiGateway.get(
      '/wohc/get-wohc-detail-information?woHcId=$woHcId',
    );
  }

  @override
  Future<Response> getProcessDetail({
    required int taskPlanId,
    required int employeeCode,
  }) {
    return _apiGateway.get(
      '/task/find-progress-detail?taskPlanId=$taskPlanId&employeeCode=$employeeCode',
    );
  }

  @override
  Future<Response> acceptWohcAssign({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/accept-wohc-assign',
      data: request,
    );
  }

  @override
  Future<Response> extendWohc({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/extend-wohc',
      data: request,
    );
  }

  @override
  Future<Response> actionCompleteWo({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/complete-wohc',
      data: request,
    );
  }

  @override
  Future<Response> processWohc({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/process-wohc',
      data: request,
    );
  }

  @override
  Future<Response> uploadFile({
    required FormData formData,
  }) {
    return _apiGateway.post(
      '/wohc/uploadSurveyCLDV',
      data: formData,
    );
  }

  @override
  Future<Response> saveSurveyCLDV({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/wohc/saveSurveyCLDV',
      data: request,
    );
  }

}
