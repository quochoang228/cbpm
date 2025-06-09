part of '../../wo.dart';

final listWoProvider =
StateNotifierProvider.autoDispose<ListWoViewModel, DataState<List<WoResponse>, ErrorResponse>>(
      (ref) => ListWoViewModel(ref: ref),
);

class ListWoViewModel extends StateNotifier<DataState<List<WoResponse>, ErrorResponse>> {
  final Ref ref;

  ListWoViewModel({
    required this.ref,
  }) : super(NotLoaded<List<WoResponse>>());

  Future<void> getListWo(WoRequest request) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<List<WoResponse>>();
    try {
      final result = await Dependencies().getIt<IOCWoRepository>().getListWo(
        request: request.toJson(),
      );
      result.when(
        success: (data) {
          if (data.data != null) {
            state = Fetched(data.data ?? []);
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
