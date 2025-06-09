part of '../../wo.dart';

class CustomerFeedbackSurveyPage extends StatefulHookConsumerWidget {
  const CustomerFeedbackSurveyPage({super.key, required this.woDetail});

  final WoDetail woDetail;

  @override
  ConsumerState<CustomerFeedbackSurveyPage> createState() =>
      _CustomerFeedbackSurveyPageState();
}

class _CustomerFeedbackSurveyPageState
    extends ConsumerState<CustomerFeedbackSurveyPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Khảo sát ý kiến khách hàng',
          style: DSTextStyle.headlineLarge.semiBold().copyWith(
                color: DSColors.backgroundWhite,
              ),
        ),
        iconTheme: IconThemeData(color: DSColors.backgroundWhite),
        centerTitle: true,
        backgroundColor: DSColors.primary,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I. Thông tin chung',
                  style: DSTextStyle.headlineMedium.copyWith(
                    color: DSColors.textLabel,
                  ),
                  textAlign: TextAlign.left,
                ),
                16.height,
                Divider(),
                16.height,
                FormBuilderTextField(
                  title: 'Họ và tên',
                  controller: fullNameController,
                  isRequired: true,
                  validator: (val) {
                    if ((val ?? '').isEmpty) {
                      return "Trường bắt buộc nhập";
                    }
                    return null;
                  },
                ),
                16.height,
                FormBuilderTextField(
                  title: 'Số điện thoại',
                  controller: phoneNumberController,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if ((val ?? '').isEmpty) {
                      return "Trường bắt buộc nhập";
                    }
                    return null;
                  },
                ),
                16.height,
                FormBuilderTextField(
                  title: 'Chức danh người khảo sát',
                  controller: positionController,
                  isRequired: true,
                  validator: (val) {
                    if ((val ?? '').isEmpty) {
                      return "Trường bắt buộc nhập";
                    }
                    return null;
                  },
                ),
                16.height,
                FormBuilderTextField(
                  title: 'Thông tin đơn vị khảo sát',
                  controller: departmentController,
                  validator: (val) {
                    if ((val ?? '').isEmpty) {
                      return "Trường bắt buộc nhập";
                    }
                    return null;
                  },
                ),
                16.height,
                Text(
                  'II. Nội dung khảo sát',
                  style: DSTextStyle.headlineMedium.copyWith(
                    color: DSColors.textLabel,
                  ),
                  textAlign: TextAlign.left,
                ),
                16.height,
                Divider(),
                16.height,
                ListView.separated(
                  itemCount: widget.woDetail.listQuestion?.length ?? 0,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    final item = widget.woDetail.listQuestion![index];
                    if (item.isNumberQuestion) {
                      return _buildQuestionFieldNumber(
                        item: item,
                      );
                    }
                    return _buildQuestionField(
                      item: item,
                    );
                  },
                ),
                SizedBox(height: 16),
                DSButton(
                  label: "Lưu lại",
                  onPressed: () async {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid == true) {
                      _formKey.currentState?.save();
                      onSubmit();
                    } else {
                      print("Validation failed");
                    }
                  },
                  backgroundColor: DSColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionField({
    required QuestionEntity item,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.question ?? '',
          style: DSTextStyle.headlineSmall,
        ),
        8.height,
        FormBuilderTextField(
          title: 'Nhập câu trả lời',
          keyboardType: TextInputType.text,
          initialValue: item.answer,
          onChanged: (value) {
            item.answer = value;
          },
          minLines: 1,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildQuestionFieldNumber({
    required QuestionEntity item,
  }) {
    bool isInvalidInitialValue = int.tryParse(item.answer ?? '') == null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.question ?? '',
          style: DSTextStyle.headlineSmall,
        ),
        8.height,
        FormBuilderTextField(
          title: 'Nhập số',
          keyboardType: TextInputType.number,
          initialValue: item.answer ?? null,
          validator: (value) {
            final input = value?.trim();
            if (input?.isNotEmpty ?? false) {
              final parsed = int.tryParse(input!);
              if (parsed == null || parsed <= 0 || parsed > 10) {
                return 'Vui lòng nhập số nguyên dương nhỏ hơn hoặc bằng 10';
              }
            }
            return null;
          },
          onChanged: (value) {
            item.answer = value;
          },
        ),
      ],
    );
  }

  Future<void> onSubmit() async {
    var body = FeedbackSurveyBody(
      woHcId: widget.woDetail.woHcId,
      type_pks: widget.woDetail.type_pks, // PT_HTCT, VHKT
      cus_info: CustomerInfo(
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        position: positionController.text,
        department: departmentController.text,
      ),
      listQuestion: widget.woDetail.listQuestion,
    );
    var result = await ref.read(updateWoProvider.notifier).saveSurveyCLDV(
      request: body,
    );
    if( result) {
      showToast('Lưu khảo sát thành công');
      Navigator.pop(context, true);
    } else {
      showToast('Lưu khảo sát thất bại');
    }
  }
}
