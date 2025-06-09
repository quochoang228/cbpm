import 'package:ag/ag.dart';
import 'package:construction/src/entities/constructions_reponse.dart';

import '../api/construction_api.dart';
import '../local/construction_storage.dart';

abstract class ConstructionRepository {
  Future<BaseResult<DataResponse<ConstructionsReponse>>> findAllByStatus({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<DataResponse<ConstructionsReponse>>> findAllConstruction({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<DataResponse<ConstructionDetailResponseData>>>
      findByConstructionId({
    required Map<String, dynamic> request,
  });
}

class ConstructionRepositoryImpl extends BaseRepository
    implements ConstructionRepository {
  ConstructionRepositoryImpl({
    required ConstructionApi api,
    required ConstructionLocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  final ConstructionApi _api;
  final ConstructionLocalStorage _localStorage;

  @override
  Future<BaseResult<DataResponse<ConstructionsReponse>>> findAllByStatus({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.findAllByStatus(request: request),
        mapper: (data) {
          return DataResponse<ConstructionsReponse>.fromJson(
            data,
            (Object? obj) =>
                ConstructionsReponse.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<DataResponse<ConstructionsReponse>>> findAllConstruction({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.findAllConstruction(request: request),
        mapper: (data) {
          return DataResponse<ConstructionsReponse>.fromJson(
            data,
            (Object? obj) =>
                ConstructionsReponse.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<DataResponse<ConstructionDetailResponseData>>>
      findByConstructionId({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.findByConstructionId(request: request),
        mapper: (data) {
          return DataResponse<ConstructionDetailResponseData>.fromJson(
            data,
            (Object? obj) => ConstructionDetailResponseData.fromJson(
                obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
