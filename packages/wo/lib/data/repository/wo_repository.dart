part of '../../../wo.dart';

abstract class IOCWoRepository {
  Future<BaseResult<ListDataResponse<WoResponse>>> getListWo({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<UpdateDataResponse>> acceptWohcAssign({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<DataResponse<WoDetail>>> getWoDetail({
    required int woHcId,
  });

  Future<BaseResult<UpdateDataResponse>> extendWohc({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<UpdateDataResponse>> processWohc({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<UpdateDataResponse>> actionCompleteWo({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<UpdateDataResponse>> saveSurveyCLDV({
    required Map<String, dynamic> request,
  });

  Future<BaseResult<UpdateDataResponse>> uploadFile({
    required int woHcId,
    required List<ImageUpdate> files,
  });
}

class IOCWoRepositoryImpl extends BaseRepository implements IOCWoRepository {
  IOCWoRepositoryImpl({
    required IOCWoApi api,
  }) : _api = api;

  final IOCWoApi _api;

  @override
  Future<BaseResult<ListDataResponse<WoResponse>>> getListWo({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.getListWo(request: request),
        mapper: (data) {
          return ListDataResponse<WoResponse>.fromJson(
            data["data"] as Map<String, dynamic>,
            (Object? obj) => WoResponse.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<DataResponse<WoDetail>>> getWoDetail({
    required int woHcId,
  }) async {
    try {
      return await safeApiCall(
        _api.getWoDetail(woHcId: woHcId),
        mapper: (data) {
          return DataResponse<WoDetail>.fromJson(
            data as Map<String, dynamic>,
            (Object? obj) => WoDetail.fromJson(obj as Map<String, dynamic>),
          );
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> acceptWohcAssign({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.acceptWohcAssign(request: request),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> extendWohc({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.extendWohc(request: request),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> processWohc({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.processWohc(request: request),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> actionCompleteWo({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.actionCompleteWo(request: request),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> saveSurveyCLDV({
    required Map<String, dynamic> request,
  }) async {
    try {
      return await safeApiCall(
        _api.saveSurveyCLDV(request: request),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<BaseResult<UpdateDataResponse>> uploadFile({
    required int woHcId,
    required List<ImageUpdate> files,
  }) async {
    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry("woHcId", woHcId.toString()));
      for (final e in files) {
        formData.files.add(
          MapEntry(
            "files",
            await MultipartFile.fromFile(
              e.filePath ?? '',
              filename: e.name,
            ),
          ),
        );
      }
      return await safeApiCall(
        _api.uploadFile(formData: formData),
        mapper: (data) {
          return UpdateDataResponse.fromJson(data as Map<String, dynamic>);
        },
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
