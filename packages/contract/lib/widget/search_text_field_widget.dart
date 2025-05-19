part of '../../contract.dart';

class SearchTextFieldWidget extends HookConsumerWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final Function(String content)? onChanged;
  final Function(String content)? onSubmitted;
  final String? hintText;
  final TextStyle? style;
  final Color? borderColor;

  const SearchTextFieldWidget({
    super.key,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.style,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    var content = useState('');

    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: DSColors.backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor ?? DSColors.borderDefault,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: style ?? DSTextStyle.bodySmall,
        autofocus: autofocus,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          content.value = value;
          onChanged?.call(value);
        },
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          suffixIcon: content.value.isNotEmpty
              ? InkWell(
                  onTap: () {
                    controller?.clear();
                    content.value = '';
                    onChanged?.call('');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CDNAssets.icons.closeCircle.svg(),
                  ),
                )
              : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CDNAssets.icons.search.svg(),
          ),
          hintText: hintText ?? 'Tìm kiếm',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 8, top: 4),
          hintStyle: DSTextStyle.bodySmall.copyWith(),
        ),
      ),
    );
  }
}
