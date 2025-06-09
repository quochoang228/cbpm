part of '../../wo.dart';

class SelectDateTimeWidget extends StatelessWidget {
  const SelectDateTimeWidget(
      {super.key,
      required this.title,
      this.tapOnly = false,
      this.controller,
      this.onTap,
      this.isRequired = true,
      this.readOnly = false,
      this.validator,
      });
  final Function? onTap;
  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  final tapOnly;
  final bool isRequired;
  final String? Function(String?)? validator;

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
        readOnly: readOnly || tapOnly,
        onTap: () async {
          if (!readOnly) {
            onTap?.call();
          }
        },
        validator: validator,
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
          suffixIcon: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CDNAssets.icons.calendar1.svg(
                  color: Color(0xFF525252),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
