part of '../../wo.dart';

class OutputData {
  const OutputData({this.id, this.index});
  final int? id;
  final int? index;
}

class CustomMultiFilePicker extends StatelessWidget {
  const CustomMultiFilePicker({
    super.key,
    this.enabled = true,
    this.required = false,
    this.hintText,
    this.service,
    this.validator,
    this.onChanged,
    this.onRemoveFile,
    this.initFiles,
  });

  final bool enabled;
  final bool required;
  final String? hintText;
  final String? service;
  final FormFieldValidator<List<File>>? validator;
  final ValueChanged<List<File>>? onChanged;
  final ValueChanged<OutputData>? onRemoveFile;
  final List<ImageUpdate>? initFiles;

  @override
  Widget build(BuildContext context) {
    return FormField<List<File>>(
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ??
          (required
              ? (value) {
                  return value == null ? 'Vui lòng tải lên $hintText' : null;
                }
              : null),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 66,
              child: DottedBorder(
                color: !field.hasError ? Color(0xffd4d4d4) : Color(0xffe81c2d),
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                dashPattern: [10, 5, 10, 5, 10, 5],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () => _showAction(context, field),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 16),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffeaeaea),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CDNAssets.icons.documentUpload.svg(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Tải lên tệp tin',
                                    style: TextStyle(
                                      color: Color(0xff525252),
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Định dạng PDF, JPG, PNG',
                                    style: TextStyle(
                                      color: Color(0xff7f7f7f),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...(initFiles ?? []).asMap().entries.map((entry) {
              int index = entry.key; // Lấy index
              var file = entry.value; // Lấy phần tử
              return
                GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      SizedBox(
                        height: 66,
                        child: DottedBorder(
                          color: Color(0xffd4d4d4),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          dashPattern: [10, 5, 10, 5, 10, 5],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 16),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffeaeaea),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CDNAssets.icons.check.svg(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            (file.filePath ?? "").split('/').last ?? 'Tải lên tệp tin',
                                            style: TextStyle(
                                              color: Color(0xff2d84ff),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Định dạng PDF, JPG, PNG tối đa 2GB/file',
                                            style: TextStyle(
                                              color: Color(0xff7f7f7f),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoButton(
                                onPressed: () {
                                  onRemoveFile?.call(OutputData(id: file.id, index: index));
                                },
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: CDNAssets.icons.iconTrash.svg(
                                  width: 16,
                                  height: 16,
                                  color: Color(0xff7f7f7f),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ;
            }),
            if (field.hasError) SizedBox(height: 10),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: Color(0xffe81c2d), fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile(BuildContext context, FormFieldState<List<File>> field) async {
    var resultFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    final files = resultFile?.files;

    if (files?.isEmpty ?? true) return;
    bool isMaxSize = false;

    var maxFileSizeInBytes = 5 * 1048576;
    List<File> filesSuccess = [];
    for (var xfile in (files ?? [])) {
      File file = File(xfile.path);
      int fileSize = await file.length();
      if (fileSize <= maxFileSizeInBytes) {
        filesSuccess.add(file);
      } else {
        isMaxSize = true;
      }
    }

    if (isMaxSize) {
      toast('File không được lớn hơn 5M');
      if (filesSuccess.length == 0)
        return;
    }

    final newFiles = List<File>.from(field.value ?? []);
    newFiles.addAll((files ?? []).map((e) => File(e.path ?? '')));

    field.didChange(newFiles);
    onChanged?.call(newFiles);
  }

  Future<void> _pickImage(BuildContext context, FormFieldState<List<File>> field, ImageSource imageSource) async {
    final _picker = ImagePicker();
    final newFiles = List<File>.from(field.value ?? []);

    if (imageSource == ImageSource.gallery) {
      final results = await _picker.pickMultiImage(imageQuality: 100);

      bool isMaxSize = false;
      var maxFileSizeInBytes = 5 * 1048576;
      List<File> filesSuccess = [];
      for (var xfile in results) {
        File file = File(xfile.path);
        int fileSize = await file.length();
        if (fileSize <= maxFileSizeInBytes) {
          filesSuccess.add(file);
        } else {
          isMaxSize = true;
        }
      }

      if (isMaxSize) {
        toast('Ảnh không được lớn hơn 5M');
        if (filesSuccess.length == 0)
          return;
      }

      newFiles.addAll(results.map((e) => File(e.path)));
    } else {
      final result = await _picker.pickImage(source: imageSource, imageQuality: 100);

      if (result == null) return;

      var maxFileSizeInBytes = 5 * 1048576;

      var fileSize = await result.readAsBytes();

      if (fileSize.length > maxFileSizeInBytes) {
        toast('Ảnh không được lớn hơn 5M');
        return;
      }

      newFiles.add(File(result.path));
    }

    field.didChange(newFiles);
    onChanged?.call(newFiles);
  }

  void _showAction(BuildContext context, FormFieldState<List<File>> field) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Container(
              height: 16,
              color: Colors.transparent,
            ),
            // ListTile(
            //   leading: Icon(Icons.photo_camera_outlined),
            //   title: Text('Chụp ảnh'),
            //   onTap: () {
            //     _pickImage(context, field, ImageSource.camera);
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.photo_library_outlined),
            //   title: Text('Chọn ảnh'),
            //   onTap: () {
            //     _pickImage(context, field, ImageSource.gallery);
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.file_present_outlined),
              title: Text('Chọn tệp tin'),
              onTap: () {
                _pickFile(context, field);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isPdfOrImage(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase(); // Chuyển thành chữ thường
    return lowerCaseFileName.endsWith('.pdf') ||
        lowerCaseFileName.endsWith('.jpeg') ||
        lowerCaseFileName.endsWith('.jpg') ||
        lowerCaseFileName.endsWith('.png');
  }
}
