// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:gap/gap.dart';
// import 'package:hoagsource/hoagsource.dart';
// class JobbyTextField extends StatelessWidget {
//   const JobbyTextField({
//     super.key,
//     required this.name,
//     this.title,
//     this.controller,
//     this.hintText,
//     this.initialValue,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onChanged,
//     this.validator,
//     this.isRequired = false,
//     this.enabled = true,
//     this.autofocus = false,
//     this.obscureText = false,
//     this.textInputType,
//     this.maxLines,
//     this.minLines = 1,
//     this.maxLength,
//     this.borderRadius,
//     this.contentPadding,
//     this.decoration,
//     this.inputFormatters,
//     this.onTap,
//     this.isShowFullInfo = false,
//     this.onShowFullInfo,
//   });

//   final TextEditingController? controller;
//   final String name;
//   final String? hintText;
//   final String? initialValue;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final Function? onChanged;
//   final String? Function(String?)? validator;
//   final bool isRequired;
//   final bool enabled;
//   final bool autofocus;
//   final bool obscureText;
//   final int? maxLines;
//   final int? minLines;
//   final int? maxLength;
//   final TextInputType? textInputType;
//   final BorderRadius? borderRadius;
//   final EdgeInsetsGeometry? contentPadding;
//   final InputDecoration? decoration;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? title;
//   final bool isShowFullInfo;
//   final Function? onShowFullInfo;

//   /// On tap text field
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: title != null
//                   ? RichText(
//                       text: TextSpan(
//                           text: title ?? '',
//                           style: const JobbyTextTheme.fallback()
//                               .smallTextMedium
//                               ?.applyColor(JobbyColors.gray900),
//                           children: [
//                             TextSpan(
//                               text: isRequired ? ' *' : '',
//                               style: const JobbyTextTheme.fallback()
//                                   .smallTextMedium
//                                   ?.applyColor(CoreColors.red),
//                             ),
//                           ]),
//                     )
//                   : const SizedBox(),
//             ),
//             isShowFullInfo
//                 ? Row(
//                     children: [
//                       const Gap(8),
//                       InkWell(
//                         onTap: () {
//                           if (onShowFullInfo != null) {
//                             onShowFullInfo!();
//                           }
//                         },
//                         child: Text(
//                           'Xem đầy đủ thông tin',
//                           style: const JobbyTextTheme.fallback()
//                               .captionMedium
//                               ?.applyColor(CoreColors.blue),
//                         ),
//                       ),
//                     ],
//                   )
//                 : const SizedBox(),
//           ],
//         ),
//         title != null ? const Gap(8) : const SizedBox(),
//         isShowFullInfo ? const Gap(8) : const SizedBox(),
//         InkWell(
//           onTap: onTap,
//           child: AbsorbPointer(
//             absorbing: onTap != null,
//             child: FormBuilderTextField(
//               controller: controller,
//               name: name,
//               initialValue: initialValue,
//               enabled: enabled,
//               maxLines: maxLines,
//               minLines: minLines,
//               maxLength: maxLength,
//               autofocus: autofocus,
//               cursorColor: JobbyColors.gray900,
//               obscureText: obscureText,
//               onEditingComplete: () {},
//               // onTap: onTap,
//               onChanged: (value) {
//                 if (onChanged != null) {
//                   onChanged!();
//                 }
//               },
//               validator: validator,
//               // validator: FormBuilderValidators.required(
//               //   checkNullOrEmpty: true,
//               //   errorText: 'Trường bắt buộc',
//               // ),

//               decoration: decoration ??
//                   InputDecoration(
//                     hintText: hintText,
//                     hintStyle: const JobbyTextTheme.fallback()
//                         .smallTextRegular
//                         ?.applyColor(
//                           JobbyColors.gray500,
//                         ),
//                     filled: true,
//                     fillColor:
//                         enabled ? CoreColors.transparent : JobbyColors.gray100,
//                     contentPadding: contentPadding ??
//                         const EdgeInsets.symmetric(
//                           vertical: 14.0,
//                           horizontal: 16.0,
//                         ),
//                     prefixIcon: prefixIcon,
//                     suffixIcon: suffixIcon,
//                     border: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: const BorderSide(
//                         color: JobbyColors.gray800,
//                       ),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: const BorderSide(
//                         color: CoreColors.red,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: const BorderSide(
//                         color: CoreColors.red,
//                       ),
//                     ),
//                     // helperText: isRequired ? 'Trường bắt buộc' : null,
//                     // helperStyle: BaseTextStyle.captionSmall.applyColor(
//                     //   BaseColors.textSubtitle,
//                     // ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: const BorderSide(
//                         color: JobbyColors.gray200,
//                       ),
//                       // isRequired
//                       //     ? const BorderSide(
//                       //         color: CoreColors.red,
//                       //       )
//                       //     :
//                       // BorderSide.none,
//                     ),
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: borderRadius ??
//                           BorderRadius.circular(BaseRadius.radiusMd),
//                       borderSide: const BorderSide(
//                         color: JobbyColors.gray200,
//                       ),
//                     ),
//                   ),
//               textInputAction: TextInputAction.done,
//               onSubmitted: (value) {
//                 FocusScope.of(context).unfocus();
//               },
//               keyboardType: textInputType ?? TextInputType.text,
//               inputFormatters: inputFormatters,
//               style: const JobbyTextTheme.fallback()
//                   .smallTextRegular
//                   ?.applyColor(JobbyColors.gray800),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
