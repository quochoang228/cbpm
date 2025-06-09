part of '../../wo.dart';

class FormBuilderTextField extends StatelessWidget {
  const FormBuilderTextField({
    super.key,
    required this.title,
    this.controller,
    this.maxLines,
    this.minLines,
    this.validator,
    this.decoration,
    this.keyboardType,
    this.isRequired = false,
    this.readOnly = false,
    this.initialValue,
    this.onChanged,
  });

  final String title;
  final TextEditingController? controller;
  final int? maxLines, minLines;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool isRequired;
  final bool readOnly;
  final String? initialValue;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: readOnly ? DSColors.borderDefault : Colors.white,
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
        enabled: !readOnly,
        readOnly: readOnly,
        validator: validator,
        initialValue: initialValue,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: minLines,
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
        ),
      ),
    );
  }
}
