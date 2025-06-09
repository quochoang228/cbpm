import 'package:ag/ag.dart';

abstract class ConstructionApi {
  Future<Response> findAllByStatus({
    required Map<String, dynamic> request,
  });

  Future<Response> findAllConstruction({
    required Map<String, dynamic> request,
  });

  Future<Response> findByConstructionId({
    required Map<String, dynamic> request,
  });
}

class ConstructionApiImpl implements ConstructionApi {
  final ApiGateway _apiGateway;

  ConstructionApiImpl({
    required ApiGateway apiGateway,
  }) : _apiGateway = apiGateway;

  @override
  Future<Response> findAllByStatus({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.get(
      '/constructionPlan/find-all-by-status',
      queryParameters: request,
    );
  }

  @override
  Future<Response> findAllConstruction({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.post(
      '/constructionPlan/find-all-construction',
      data: request,
    );
  }

  @override
  Future<Response> findByConstructionId({
    required Map<String, dynamic> request,
  }) {
    return _apiGateway.get(
      '/taskPlan/find-by-constructionId',
      queryParameters: request,
    );
  }

  // @override
  // Future<Response> viewFileSignContract({
  //   required Map<String, dynamic> request,
  // }) {
  //   return _apiGateway.post(
  //     '/common/viewFileSignContract',
  //     data: request,
  //   );
  // }
}
