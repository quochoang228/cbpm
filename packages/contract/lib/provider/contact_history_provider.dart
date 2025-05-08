part of '../../contract.dart';

final contactHistoryProvider = StateNotifierProvider.autoDispose<ContactHistoryProvider, DataState<List<ContractElectronicDto>, ErrorResponse>>(
      (ref) => ContactHistoryProvider(ref),
);

class ContactHistoryProvider extends StateNotifier<DataState<List<ContractElectronicDto>, ErrorResponse>> {
  ContactHistoryProvider(this.ref) : super(NotLoaded<List<ContractElectronicDto>>());

  final Ref ref;

  List<ContractElectronicDto> dataBackup = [];

  Future<void> getListContract({String? keySearch}) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<List<ContractElectronicDto>>();
    try {
      final result = await Dependencies().getIt<IOCContactRepository>().getListContract(
        request: {
          'page': 1,
          'pageSize': 10,
          'keySearch': "",
          // 'userNameAio' : Dependencies().getIt<AuthService>().user?.email,
        },
      );
      result.when(
        success: (data) {
          if (data.data?.isNotEmpty ?? false) {
            state = Fetched(data.data!);
            dataBackup = data.data!;
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

// void filter(WoStationStatusEnum woStationStatusEnum) {
//   if (dataBackup.isEmpty) return;
//   final filteredData = woStationStatusEnum == WoStationStatusEnum.all
//       ? dataBackup
//       : dataBackup.where((element) => element.status == woStationStatusEnum.status).toList();
//
//   state = filteredData.isEmpty ? NoData() : Fetched(filteredData);
// }
}
