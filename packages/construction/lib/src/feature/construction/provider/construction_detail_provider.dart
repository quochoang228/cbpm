import 'package:ag/ag.dart';
import 'package:auth/auth.dart';
import 'package:di/di.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../construction.dart';
import '../../../entities/construction_dto.dart';

final constructionDetailProvider = StateNotifierProvider.autoDispose<
    ConstructionDetailProvider, DataState<ConstructionDto, ErrorResponse>>(
  (ref) => ConstructionDetailProvider(ref),
);

class ConstructionDetailProvider
    extends StateNotifier<DataState<ConstructionDto, ErrorResponse>> {
  ConstructionDetailProvider(this.ref) : super(NotLoaded<ConstructionDto>());

  final Ref ref;

  Future<void> findByConstructionId(
    int constructionId,
  ) async {
    if (state.state == CurrentDataState.loading) return;

    state = Loading<ConstructionDto>();
    try {
      var user = await Dependencies().getIt<AuthService>().getUser();
      if (user == null) {
        state = Failed(ErrorResponse(message: 'Không tìm thấy người dùng'));
        return;
      }

      final result = await Dependencies()
          .getIt<ConstructionRepository>()
          .findByConstructionId(
        request: {
          'employeeCode': user.preferredUsername,
          'constructionId': constructionId,
        },
      );
      result.when(
        success: (data) {
          if (data.status == 200 && data.data != null) {
            state = Fetched(data.data!.data!);
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
}
