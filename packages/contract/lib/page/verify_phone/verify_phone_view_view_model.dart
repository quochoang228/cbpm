// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// part 'verify_phone_view_state.dart';
//
// final verifyPhoneProvider =
//     StateNotifierProvider.autoDispose<VerifyPhoneViewModel, VerifyPhoneState>(
//         (ref) => VerifyPhoneViewModel(ref: ref));
//
// class VerifyPhoneViewModel extends StateNotifier<VerifyPhoneState> {
//   final Ref ref;
//
//   VerifyPhoneViewModel({
//     required this.ref,
//   }) : super(const VerifyPhoneState());
//
//   Future<void> verifyOTP({
//     required String? orderCode,
//     required String? userName,
//     required String? otp,
//     required String type,
//   }) async {
//     state = state.copyWith(
//       loadDataStatus: LoadStatus.loading,
//     );
//
//     try {
//       late final BaseResult? result;
//       if (type == SendOtpType.updateOrder.keyToServer) {
//         result = await appLocator<OrderRepository>().verifyOtpUpdateOrder(
//           body: SendOTPBody(
//             orderCode: orderCode,
//             username: userName,
//             otp: otp,
//             type: type,
//           ),
//         );
//       } else {
//         result = await appLocator<AuthRepository>().verifyOTP(
//           body: SendOTPBody(
//             username: userName,
//             otp: otp,
//             type: type,
//           ),
//         );
//       }
//       result?.when(
//         success: (data) async {
//           state = state.copyWith(
//             loadDataStatus: LoadStatus.success,
//           );
//         },
//         error: (err) {
//           state = state.copyWith(
//             loadDataStatus: LoadStatus.failure,
//             message: err.message,
//           );
//         },
//       );
//     } catch (error) {
//       state = state.copyWith(
//         loadDataStatus: LoadStatus.failure,
//       );
//     }
//   }
//
//   Future<void> aioVerifyOTP() async {
//     state = state.copyWith(
//       loadDataStatus: LoadStatus.success,
//     );
//   }
// }
