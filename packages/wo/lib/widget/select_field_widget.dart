part of '../../wo.dart';

class SelectFieldWidget extends StatelessWidget {
  const SelectFieldWidget({
    super.key,
    required this.title,
    this.controller,
    this.validator,
    this.decoration,
    this.isRequired = false,
    this.initialValue,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
  });

  final String title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final bool isRequired;
  final String? initialValue;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: DSColors.borderDefault,
            width: 1,
          ),
        ),
        child: TextFormField(
          controller: controller,
          enabled: false,
          validator: validator,
          initialValue: initialValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            label: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: Color(0xFF525252),
                    ),
                  ),
                  isRequired
                      ? TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        )
                      : TextSpan(),
                ],
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(
              10.0,
              0.0,
              20.0,
              0.0,
            ),
            suffixIcon: suffixIcon != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: suffixIcon,
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}
