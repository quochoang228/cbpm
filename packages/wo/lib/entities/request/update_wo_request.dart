import '../construction_image_update.dart';

class UpdateWoRequest {
  int? woHcId;
  String? reasonReject;
  String? state;
  String? reasonNotUploadKsCLDV;
  List<String>? listFileKsCLDV;
  int? ftId;
  List<ImageUpdate>? woMappingAttachDTOList;

  UpdateWoRequest({
    this.woHcId,
    this.reasonReject,
    this.state,
    this.reasonNotUploadKsCLDV,
    this.listFileKsCLDV,
    this.ftId,
    this.woMappingAttachDTOList,
  });

  factory UpdateWoRequest.fromJson(Map<String, dynamic> json) {
    return UpdateWoRequest(
      woHcId: json['woHcId'] as int?,
      reasonReject: json['reasonReject'] as String?,
      state: json['state'] as String?,
      reasonNotUploadKsCLDV: json['reasonNotUploadKsCLDV'] as String?,
      listFileKsCLDV: (json['listFileKsCLDV'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ftId: json['ftId'] as int?,
      woMappingAttachDTOList:
      (json['woMappingAttachDTOList'] as List<dynamic>?)
          ?.map((e) => ImageUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'woHcId': woHcId,
    'reasonReject': reasonReject,
    'state': state,
    'reasonNotUploadKsCLDV': reasonNotUploadKsCLDV,
    'listFileKsCLDV': listFileKsCLDV,
    'ftId': ftId,
    'woMappingAttachDTOList':
    woMappingAttachDTOList?.map((e) => e.toJson()).toList(),
  };
}
