part of '../../wo.dart';

final detailWoProvider = StateNotifierProvider.autoDispose<DetailWoViewModel,
    DataState<WoDetail, ErrorResponse>>(
  (ref) => DetailWoViewModel(ref: ref),
);

class DetailWoViewModel
    extends StateNotifier<DataState<WoDetail, ErrorResponse>> {
  final Ref ref;

  DetailWoViewModel({
    required this.ref,
  }) : super(NotLoaded<WoDetail>());

  Future<void> getWoDetail(int woHcId) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<WoDetail>();
    try {
      final result = await Dependencies().getIt<IOCWoRepository>().getWoDetail(
            woHcId: woHcId
          );
      result.when(
        success: (data) {
          if (data.data != null) {
            state = Fetched(data.data ?? WoDetail());
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
}
