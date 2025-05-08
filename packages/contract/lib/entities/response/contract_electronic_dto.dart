import 'dart:typed_data';
import 'package:contract/entities/uint8/unint8_converter.dart';

class ContractElectronicDto {
  int? contractPmxlId;
  String? contractCode;
  String? signGroupName;
  int? price;
  String? contractBranch;
  int? state;
  String? signDateStr;
  String? startDateStr;
  String? endDateStr;
  String? provinceName;
  String? stateStr;
  bool? showButtonSign;
  String? appendixCode;
  String? createdUserName;
  String? signStateName;
  String? phonePartner;
  String? partnerName;

  ContractElectronicDto({
    this.contractPmxlId,
    this.contractCode,
    this.signGroupName,
    this.price,
    this.contractBranch,
    this.state,
    this.signDateStr,
    this.startDateStr,
    this.endDateStr,
    this.provinceName,
    this.stateStr,
    this.showButtonSign,
    this.signStateName,
    this.createdUserName,
    this.appendixCode,
    this.phonePartner,
    this.partnerName,
  });

  factory ContractElectronicDto.fromJson(Map<String, dynamic> json) {
    return ContractElectronicDto(
      contractPmxlId: json['contractPmxlId'],
      contractCode: json['contractCode'],
      signGroupName: json['signGroupName'],
      price: json['price'],
      contractBranch: json['contractBranch'],
      state: json['state'],
      signDateStr: json['signDateStr'],
      startDateStr: json['startDateStr'],
      endDateStr: json['endDateStr'],
      provinceName: json['provinceName'],
      stateStr: json['stateStr'],
      showButtonSign: json['showButtonSign'],
      appendixCode: json['appendixCode'],
      createdUserName: json['createdUserName'],
      signStateName: json['signStateName'],
      phonePartner: json['phonePartner'],
      partnerName: json['partnerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contractPmxlId': contractPmxlId,
      'contractCode': contractCode,
      'signGroupName': signGroupName,
      'price': price,
      'contractBranch': contractBranch,
      'state': state,
      'signDateStr': signDateStr,
      'startDateStr': startDateStr,
      'endDateStr': endDateStr,
      'provinceName': provinceName,
      'stateStr': stateStr,
      'showButtonSign': showButtonSign,
      'appendixCode': appendixCode,
      'createdUserName': createdUserName,
      'signStateName': signStateName,
      'phonePartner': phonePartner,
      'partnerName': partnerName,
    };
  }
}
