import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:di/di.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../construction.dart';
import '../../../entities/construction_dto.dart';

final constructionsProvider = StateNotifierProvider.autoDispose<
    ConstructionsProvider, DataState<List<ConstructionDto>, ErrorResponse>>(
  (ref) => ConstructionsProvider(ref),
);

class ConstructionsProvider
    extends StateNotifier<DataState<List<ConstructionDto>, ErrorResponse>> {
  ConstructionsProvider(this.ref) : super(NotLoaded<List<ConstructionDto>>());

  final Ref ref;

  List<ConstructionDto> dataBackup = [];

  Future<void> findAllByStatus() async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<List<ConstructionDto>>();
    try {
      var user = await Dependencies().getIt<AuthService>().getUser();
      if (user == null) {
        state = Failed(ErrorResponse(message: 'User not found'));
        return;
      }

      final result =
          await Dependencies().getIt<ConstructionRepository>().findAllByStatus(
        request: {
          'employeeCode': user.preferredUsername,
        },
      );
      result.when(
        success: (data) {
          if (data.status == 200 &&
              data.data != null &&
              (data.data?.data ?? []).isNotEmpty) {
            state = Fetched(data.data?.data ?? []);
            dataBackup = data.data?.data ?? [];
          } else {
            state = NoData();
          }
        },
        error: (p0) => state = Failed(ErrorResponse(message: p0.message)),
      );
    } catch (error) {
      state = Failed(ErrorResponse(message: error.toString()));
    }
  }

  Future<void> search({
    String? status,
    String? keySearch,
  }) async {
    if (state.state == CurrentDataState.loading) return;

    if (keySearch == null || keySearch.isEmpty) {
      state = Fetched(dataBackup);
      return;
    }

    state = Loading<List<ConstructionDto>>();
    try {
      final result = await Dependencies()
          .getIt<ConstructionRepository>()
          .findAllConstruction(
        request: {
          'status': status,
          'keySearch': keySearch,
        },
      );
      result.when(
        success: (data) {
          if (data.status == 200 &&
              data.data != null &&
              (data.data?.data ?? []).isNotEmpty) {
            state = Fetched(data.data?.data ?? []);
            dataBackup = data.data?.data ?? [];
          } else {
            state = NoData();
          }
        },
        error: (p0) => state = Failed(ErrorResponse(message: p0.message)),
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
