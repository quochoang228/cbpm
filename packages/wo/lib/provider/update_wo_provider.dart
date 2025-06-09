part of '../../wo.dart';

final updateWoProvider = StateNotifierProvider.autoDispose<UpdateWoProvider,
    DataState<WoDetail, ErrorResponse>>(
  (ref) => UpdateWoProvider(ref),
);

class UpdateWoProvider
    extends StateNotifier<DataState<WoDetail, ErrorResponse>> {
  UpdateWoProvider(this.ref) : super(NotLoaded<WoDetail>());

  final Ref ref;

  Future<bool> acceptWohcAssign({
    required int woHcId,
    bool isReject = false,
    String? reasonReject,
  }) async {
    bool res = false;
    final request = UpdateWoRequest(
      woHcId: woHcId,
      reasonReject: reasonReject,
      state: isReject ? 'REJECT_FT' : null,
    );
    try {
      final result =
          await Dependencies().getIt<IOCWoRepository>().acceptWohcAssign(
                request: request.toJson(),
              );
      result.when(
        success: (data) {
          if (data.message == 'SUCCESS' && data.status == 200) {
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

  Future<bool> extendWohc({
    required int woHcId,
    required String reason,
    required String endDate,
  }) async {
    bool res = false;
    final request = ExtendWoRequest(
      woId: woHcId,
      reason: reason,
      endDate: endDate,
    );
    try {
      final result = await Dependencies().getIt<IOCWoRepository>().extendWohc(
            request: request.toJson(),
          );
      result.when(
        success: (data) {
          if (data.message == 'SUCCESS' && data.status == 200) {
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

  Future<bool> processWohc({
    required int woHcId,
    String? reasonNotUploadKsCLDV,
    List<String>? listFileKsCLDV,
  }) async {
    bool res = false;
    final request = UpdateWoRequest(
      woHcId: woHcId,
      reasonNotUploadKsCLDV: reasonNotUploadKsCLDV,
      listFileKsCLDV: listFileKsCLDV,
    );
    try {
      final result = await Dependencies().getIt<IOCWoRepository>().processWohc(
            request: request.toJson(),
          );
      result.when(
        success: (data) {
          if (data.message == 'SUCCESS' && data.status == 200) {
            res = true;
          } else {
            showToast(data.message ?? 'Lỗi không xác định');
            res = false;
          }
        },
      );
    } catch (error) {
      res = false;
    }
    return res;
  }

  Future<bool> actionCompleteWo({
    int? woHcId,
    int? ftId,
    String? reasonNotUploadKsCLDV,
    List<ImageUpdate>? listImagePush,
  }) async {
    bool res = false;
    final request = UpdateWoRequest(
      woHcId: woHcId,
      ftId: ftId,
      woMappingAttachDTOList: listImagePush,
    );
    try {
      final result = await Dependencies()
          .getIt<IOCWoRepository>()
          .actionCompleteWo(request: request.toJson());
      result.when(
        success: (data) {
          if (data.message == 'SUCCESS' && data.status == 200) {
            res = true;
          } else {
            showToast(data.message ?? 'Lỗi không xác định');
            res = false;
          }
        },
      );
    } catch (error) {
      res = false;
    }
    return res;
  }

  Future<bool> saveSurveyCLDV({
    required FeedbackSurveyBody request,
  }) async {
    bool res = false;
    try {
      final result = await Dependencies()
          .getIt<IOCWoRepository>()
          .saveSurveyCLDV(request: request.toJson());
      result.when(
        success: (data) {
          if (data.message == 'SUCCESS' && data.status == 200) {
            res = true;
          } else {
            showToast(data.message ?? 'Lỗi không xác định');
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
