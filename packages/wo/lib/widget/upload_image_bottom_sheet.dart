part of '../../wo.dart';

class UploadImageBottomSheet extends StatefulWidget {
  final Function(File file)? onTakeImage;
  final Function(File file)? onPickImage;
  final Function(List<File> file)? onPickMultiImage;
  final Function(File file)? onPickVideo;
  final Function(File file)? onPickFile;

  const UploadImageBottomSheet({
    super.key,
    this.onPickImage,
    this.onTakeImage,
    this.onPickVideo,
    this.onPickMultiImage,
    this.onPickFile,
  });

  @override
  State<UploadImageBottomSheet> createState() => _UploadImageBottomSheetState();
}

class _UploadImageBottomSheetState extends State<UploadImageBottomSheet> {
  late PermissionStatus permissionCamera;
  late PermissionStatus permissionGallery;
  late PermissionStatus permissionStorage;

  @override
  void initState() {
    getAccessPermission();
    super.initState();
  }

  void getAccessPermission() async {
    permissionCamera = await Permission.camera.status;
    permissionGallery = await Permission.photos.status;
    permissionStorage = await Permission.storage.status;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Visibility(
          visible: widget.onTakeImage != null,
          child: ListTile(
            leading: CDNAssets.icons.contractStatus.svg(),
            title: const Text("Chụp ảnh"),
            onTap: () async {
              onCheckPermissionCamera(
                context,
                onConfirm: () async {
                  await MediaUtil.onTakeImage(
                    context: context,
                    isCheckPermission: false,
                    onSubmitImage: (file) async {
                      widget.onTakeImage?.call(file);
                    },
                  );
                },
              );
            },
          ),
        ),
        Visibility(
          visible: widget.onPickImage != null,
          child: ListTile(
            leading: CDNAssets.icons.contractStatus.svg(),
            title: const Text("Chọn ảnh"),
            onTap: () async {
              // onCheckPermissionGallery(
              //   context,
              //   onConfirm: () async {
              //     await MediaUtil.onChooseImage(
              //       onSubmitImage: (file) async {
              //         Navigator.of(context).pop();
              //         widget.onPickImage?.call(file);
              //       },
              //     );
              //   },
              // );
              await MediaUtil.onChooseImage(
                onSubmitImage: (file) async {
                  Navigator.of(context).pop();
                  widget.onPickImage?.call(file);
                },
              );
            },
          ),
        ),
        Visibility(
          visible: widget.onPickMultiImage != null,
          child: ListTile(
            leading: CDNAssets.icons.contractStatus.svg(),
            title: const Text("Chọn nhiều ảnh"),
            onTap: () async {
              final checkVersionLess33 = await checkOldAndroidVersion();

              if (checkVersionLess33) {
                onCheckPermissionStorage(
                  context,
                  onConfirm: () async {
                    await MediaUtil.onChooseMultiImage(
                      context: context,
                      maxImage: 5,
                      onSubmitMultiImage: (listFile) async {
                        widget.onPickMultiImage?.call(listFile);
                      },
                    );
                  },
                );
              } else {
                onCheckPermissionGallery(
                  context,
                  onConfirm: () async {
                    await MediaUtil.onChooseMultiImage(
                      context: context,
                      maxImage: 5,
                      onSubmitMultiImage: (listFile) async {
                        widget.onPickMultiImage?.call(listFile);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        Visibility(
          visible: widget.onPickVideo != null,
          child: ListTile(
            leading: CDNAssets.icons.contractStatus.svg(),
            title: const Text("Chọn video"),
            onTap: () async {
              final checkVersionLess33 = await checkOldAndroidVersion();

              if (checkVersionLess33) {
                onCheckPermissionStorage(
                  context,
                  onConfirm: () async {
                    await MediaUtil.onChooseVideo(
                      onSubmitVideo: (file) async {
                        widget.onPickVideo?.call(file);
                      },
                    );
                  },
                );
              } else {
                onCheckPermissionGallery(
                  context,
                  onConfirm: () async {
                    await MediaUtil.onChooseVideo(
                      onSubmitVideo: (file) async {
                        widget.onPickVideo?.call(file);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void onCheckPermissionGallery(
    BuildContext context, {
    required Function onConfirm,
  }) async {
    if (permissionGallery != PermissionStatus.denied) {
      if (permissionGallery == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        Navigator.of(context).pop();
        onConfirm();
      }
    } else {
      final result = await Permission.photos.request();
      if (result != PermissionStatus.denied) {
        if (result == PermissionStatus.permanentlyDenied) {
          if (!context.mounted) return;
          Navigator.of(context).pop();

          openAppSettings();
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pop();

          await onConfirm();
        }
      }
      permissionGallery = await Permission.photos.status;
    }
  }

  void onCheckPermissionCamera(
    BuildContext context, {
    required Function onConfirm,
  }) async {
    if (permissionCamera != PermissionStatus.denied) {
      if (permissionCamera == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        Navigator.of(context).pop();
        onConfirm();
      }
    } else {
      final result = await Permission.camera.request();
      if (result != PermissionStatus.denied) {
        if (result == PermissionStatus.permanentlyDenied) {
          if (!context.mounted) return;
          Navigator.of(context).pop();

          openAppSettings();
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pop();

          onConfirm();
        }
      }
      permissionCamera = await Permission.camera.status;
    }
  }

  void onCheckPermissionStorage(
    BuildContext context, {
    required Function onConfirm,
  }) async {
    if (permissionStorage != PermissionStatus.denied) {
      if (permissionStorage == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        Navigator.of(context).pop();
        await onConfirm();
      }
    } else {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.denied) {
        if (result == PermissionStatus.permanentlyDenied) {
          if (!context.mounted) return;
          Navigator.of(context).pop();

          openAppSettings();
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pop();
          await onConfirm();
        }
      }
      permissionStorage = await Permission.storage.status;
    }
  }

  static Future<bool> checkOldAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      if (sdkInt > 32) {
        return false;
      }
    }
    return true;
  }
}
