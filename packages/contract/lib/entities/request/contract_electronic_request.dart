import 'dart:convert';
import 'dart:typed_data';

import '../uint8/unint8_converter.dart';

class ContractElectronicRequest {
  int? page;
  int? pageSize;
  String? keySearch;
  int? objectId;
  String? content;
  int? contractId;
  int? otpId;
  String? otpCode;
  @Uint8ListConverter()
  Uint8List? imagePath;
  String? description;
  String? type;
  String? rejectContent;

  ContractElectronicRequest({
    this.page,
    this.pageSize,
    this.keySearch,
    this.objectId,
    this.content,
    this.contractId,
    this.otpId,
    this.otpCode,
    this.imagePath,
    this.description,
    this.type,
    this.rejectContent,
  });

  factory ContractElectronicRequest.fromJson(Map<String, dynamic> json) {
    return ContractElectronicRequest(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      keySearch: json['keySearch'] as String?,
      objectId: json['objectId'] as int?,
      content: json['content'] as String?,
      contractId: json['contractId'] as int?,
      otpId: json['otpId'] as int?,
      otpCode: json['otpCode'] as String?,
      imagePath: json['imagePath'],
      description: json['description'] as String?,
      type: json['type'] as String?,
      rejectContent: json['rejectContent'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'keySearch': keySearch,
      'objectId': objectId,
      'content': content,
      'contractId': contractId,
      'otpId': otpId,
      'otpCode': otpCode,
      'imagePath': imagePath,
      'description': description,
      'type': type,
      'rejectContent': rejectContent,
    };
  }
}