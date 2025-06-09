// import 'package:ds/ds.dart';
// import 'package:flutter/material.dart';
// import 'package:hoagsource/hoagsource.dart' as hoagsource;

// import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

// /// Represents the selection type options for a WoltSelectionList widget.
// enum SelectionListType {
//   /// Allows multiple items to be selected from a list.
//   multiSelect,

//   /// Allows only a single item to be selected at a time.
//   singleSelect,
// }

// class ChooseItemView<T> extends StatefulWidget {
//   const ChooseItemView({
//     super.key,
//     required this.name,
//     required this.title,
//     required this.hintText,
//     this.initialValue,
//     this.isRequired = false,
//     this.validator,
//     required this.items,
//     required this.itemsSelected,
//     required this.onSelected,
//     this.selectionListType = SelectionListType.singleSelect,
//   });

//   final String name;
//   final String title;
//   final String hintText;
//   final String? initialValue;
//   final String? Function(String?)? validator;
//   final bool isRequired;
//   final SelectionListType selectionListType;
//   final ValueChanged<Set<T>> onSelected;

//   final List<T> items;
//   final List<T> itemsSelected;

//   @override
//   State<ChooseItemView> createState() => _ChooseItemViewState<T>();
// }

// class _ChooseItemViewState<T> extends State<ChooseItemView<T>> {
//   final Set<T> selectedRecommendations = <T>{};

//   @override
//   void initState() {
//     selectedRecommendations.addAll(widget.itemsSelected);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DSTextField(
//       controller: TextEditingController(),
//       // name: widget.name,
//       // title: widget.title,
//       hintText: widget.hintText,
//       // initialValue: widget.initialValue,
//       isRequired: widget.isRequired,
//       suffix: hoagsource.BaseIcon(
//         hoagsource.BaseIcons.arrowDown1,
//         color: DSCoreColors.neutral04,
//       ),
//       onTap: () {
//         WoltModalSheet.show(
//           context: context,
//           pageListBuilder: (context) {
//             return [
//               SliverWoltModalSheetPage(
//                 isTopBarLayerAlwaysVisible: true,
//                 topBar: ColoredBox(
//                   color: DSCoreColors.white,
//                   child: Center(
//                     child: Text(
//                       'Chọn ${widget.title}',
//                       style: DSTextStyle.bodyMedium,
//                     ),
//                   ),
//                 ),
//                 trailingNavBarWidget: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'Xong',
//                     style: DSTextStyle.bodyMedium.copyWith(
//                       color: DSColors.primary,
//                     ),
//                   ),
//                 ),
//                 backgroundColor: DSColors.backgroundWhite,
//                 mainContentSliversBuilder: (context) => [
//                   SliverList.separated(
//                     itemCount: widget.items.length,
//                     separatorBuilder: (context, index) => DsDivider(
//                       color: DSCoreColors.neutral02,
//                     ),
//                     itemBuilder: (context, index) {
//                       final recommendation = widget.items[index];
//                       return ExtraRecommendationTile<T>(
//                         recommendation: recommendation,
//                         onPressed: (isSelected) {
//                           if (widget.selectionListType ==
//                               SelectionListType.singleSelect) {
//                             selectedRecommendations.clear();
//                             selectedRecommendations.add(recommendation);
//                             widget.onSelected(selectedRecommendations);
//                             Navigator.of(context).pop();
//                           } else {
//                             isSelected
//                                 ? selectedRecommendations.add(recommendation)
//                                 : selectedRecommendations
//                                     .remove(recommendation);
//                             widget.onSelected(selectedRecommendations);
//                           }
//                         },
//                         isSelected:
//                             selectedRecommendations.contains(recommendation),
//                         selectionListType: widget.selectionListType,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ];
//           },
//         );
//       },
//       validator: widget.validator,
//     );
//   }
// }

// class ExtraRecommendationTile<T> extends StatefulWidget {
//   const ExtraRecommendationTile({
//     required this.recommendation,
//     required this.isSelected,
//     required this.onPressed,
//     super.key,
//     this.selectionListType = SelectionListType.singleSelect,
//   });

//   final T recommendation;
//   final bool isSelected;
//   final ValueChanged<bool> onPressed;
//   final SelectionListType selectionListType;

//   @override
//   State<ExtraRecommendationTile> createState() =>
//       _ExtraRecommendationTileState();
// }

// class _ExtraRecommendationTileState extends State<ExtraRecommendationTile> {
//   late bool _isSelected;

//   @override
//   void initState() {
//     super.initState();
//     _isSelected = widget.isSelected;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//           widget.onPressed(_isSelected);
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: DSSpacing.spacing4,
//           vertical: DSSpacing.spacing4,
//         ),
//         color: DSColors.backgroundWhite,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Text(
//                 widget.recommendation.dictLabel ?? '',
//                 style: DSTextStyle.bodySmall,
//               ),
//             ),
//             const SizedBox(width: 16),
//             WoltSelectionListTileTrailing(
//               selectionListType: widget.selectionListType,
//               isSelected: _isSelected,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WoltSelectionListTileTrailing extends StatelessWidget {
//   const WoltSelectionListTileTrailing({
//     required this.selectionListType,
//     required this.isSelected,
//     super.key,
//   });

//   final SelectionListType selectionListType;
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     switch (selectionListType) {
//       case SelectionListType.multiSelect:
//         return CheckboxTrailing(isSelected: isSelected);
//       case SelectionListType.singleSelect:
//         return RadioTrailing(isSelected: isSelected);
//     }
//   }
// }

// class CheckboxTrailing extends StatelessWidget {
//   const CheckboxTrailing({required this.isSelected, super.key});

//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return isSelected
//         // ? MyAssets.icons.a24.checkCircleFilled.svg(
//         //     colorFilter: const ColorFilter.mode(
//         //       JobbyColors.semanticBlue500,
//         //       BlendMode.srcIn,
//         //     ),
//         //   )
//         ? hoagsource.BaseIcon(
//             hoagsource.BaseIcons.check,
//             color: DSColors.primary,
//           )
//         : const SizedBox();
//     // return _TrailingDecoration(
//     //   trailingSize: 24,
//     //   fillColor: (isSelected ? JobbyColors.semanticBlue500 : Colors.white),
//     //   child: isSelected
//     //       ? const Icon(Icons.check, size: 24, color: Colors.white)
//     //       : const SizedBox.expand(),
//     // );
//   }
// }

// class RadioTrailing extends StatelessWidget {
//   const RadioTrailing({required this.isSelected, super.key});

//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return _TrailingDecoration(
//       trailingSize: 20,
//       fillColor: isSelected ? DSColors.primary : DSCoreColors.white,
//       child: isSelected
//           ? Padding(
//               padding: const EdgeInsets.all(4),
//               child: hoagsource.BaseIcon(
//                 hoagsource.BaseIcons.check,
//                 color: DSCoreColors.white,
//               ),
//               // child: MyAssets.icons.a24.check.svg(
//               //   colorFilter: const ColorFilter.mode(
//               //     JobbyColors.grayWhite,
//               //     BlendMode.srcIn,
//               //   ),
//               // ),
//             )
//           : const SizedBox.expand(),
//     );
//   }
// }

// class _TrailingDecoration extends StatelessWidget {
//   const _TrailingDecoration({
//     required this.child,
//     required this.fillColor,
//     // ignore: unused_element
//     this.borderColor = DSCoreColors.red,
//     required this.trailingSize,
//   });

//   final Widget child;
//   final Color fillColor;
//   final Color borderColor;
//   final double trailingSize;

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: fillColor,
//         border: Border.fromBorderSide(
//           BorderSide(color: borderColor, width: 1),
//         ),
//         shape: BoxShape.circle,
//       ),
//       child: SizedBox.fromSize(size: Size.square(trailingSize), child: child),
//     );
//   }
// }
