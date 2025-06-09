part of '../../contract.dart';

final contactHistoryProvider = StateNotifierProvider.autoDispose<
    ContactHistoryProvider, DataState<MobileCallLogsResponse, ErrorResponse>>(
  (ref) => ContactHistoryProvider(ref),
);

class ContactHistoryProvider
    extends StateNotifier<DataState<MobileCallLogsResponse, ErrorResponse>> {
  ContactHistoryProvider(this.ref) : super(NotLoaded<MobileCallLogsResponse>());

  final Ref ref;

  MobileCallLogsResponse dataBackup = MobileCallLogsResponse();

  Future<void> getLogsAction({int? objectId, String? functionCode}) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<MobileCallLogsResponse>();
    try {
      final result =
          await Dependencies().getIt<IOCContactRepository>().getLogsAction(
        request: {
          'objectId': objectId,
          'functionCode': functionCode,
        },
      );
      result.when(
        success: (data) {
          if (data != null) {
            state = Fetched(data);
            dataBackup = data;
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
