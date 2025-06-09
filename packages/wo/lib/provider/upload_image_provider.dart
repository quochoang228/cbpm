part of '../../wo.dart';

final uploadImageProvider = StateNotifierProvider.autoDispose<UploadImageProvider, DataState<List<FileDataDto>, ErrorResponse>>(
      (ref) => UploadImageProvider(ref),
);

class UploadImageProvider extends StateNotifier<DataState<List<FileDataDto>, ErrorResponse>> {
  UploadImageProvider(this.ref) : super(NotLoaded<List<FileDataDto>>());

  final Ref ref;

  Future<bool> uploadFile({
    required List<ImageUpdate> files,
    required int woHcId,
  }) async {
    bool res = false;
    try {
      final result = await Dependencies().getIt<IOCWoRepository>().uploadFile(
        files: files,
        woHcId: woHcId,
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
}
