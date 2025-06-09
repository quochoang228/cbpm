import 'dart:convert';

class ConstructionDto {
  final int? constructionPlanId;
  final String? planCode;
  final String? address;
  final String? duration;
  final String? planName;
  final int? constructionId;
  final String? constructionCode;
  final int? contractId;
  final String? contractCode;
  final List<WorkDto>? listWork;
  final int? constructionStatus;
  final int? performerId;
  final bool? employeeQlcl;

  ConstructionDto({
    this.constructionPlanId,
    this.planCode,
    this.planName,
    this.address,
    this.duration,
    this.constructionId,
    this.constructionCode,
    this.contractId,
    this.contractCode,
    this.listWork,
    this.constructionStatus,
    this.performerId,
    this.employeeQlcl,
  });

  factory ConstructionDto.fromRawJson(String str) =>
      ConstructionDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConstructionDto.fromJson(Map<String, dynamic> json) =>
      ConstructionDto(
        constructionPlanId: json["constructionPlanId"],
        planCode: json["planCode"],
        planName: json["planName"],
        address: json["address"],
        duration: json["duration"],
        constructionId: json["constructionId"],
        constructionCode: json["constructionCode"],
        contractId: json["contractId"],
        contractCode: json["contractCode"],
        listWork: json["listWork"] == null
            ? []
            : List<WorkDto>.from(
                json["listWork"]!.map((x) => WorkDto.fromJson(x))),
        constructionStatus: json["constructionStatus"],
        performerId: json["performerId"],
        employeeQlcl: json["employeeQlcl"],
      );

  Map<String, dynamic> toJson() => {
        "constructionPlanId": constructionPlanId,
        "planCode": planCode,
        "planName": planName,
        "address": address,
        "duration": duration,
        "constructionId": constructionId,
        "constructionCode": constructionCode,
        "contractId": contractId,
        "contractCode": contractCode,
        "listWork": listWork == null
            ? []
            : List<dynamic>.from(listWork!.map((x) => x.toJson())),
        "constructionStatus": constructionStatus,
        "performerId": performerId,
        "employeeQlcl": employeeQlcl,
      };
}

class WorkDto {
  final int? taskPlanId;
  final int? constructionPlanId;
  final String? name;
  final int? status;
  final List<ElementDto>? list;
  final String? isApprove;
  final String? stateCode;
  final int? woHcId;
  final String? stateName;
  final bool? showBtnChangeStateWo;

  WorkDto({
    this.taskPlanId,
    this.constructionPlanId,
    this.name,
    this.status,
    this.list,
    this.isApprove,
    this.stateCode,
    this.woHcId,
    this.stateName,
    this.showBtnChangeStateWo,
  });

  factory WorkDto.fromRawJson(String str) => WorkDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkDto.fromJson(Map<String, dynamic> json) => WorkDto(
        taskPlanId: json["taskPlanId"],
        constructionPlanId: json["constructionPlanId"],
        name: json["name"],
        status: json["status"],
        list: json["list"] == null
            ? []
            : List<ElementDto>.from(
                json["list"]!.map((x) => ElementDto.fromJson(x))),
        isApprove: json["isApprove"],
        stateCode: json["stateCode"],
        woHcId: json["woHcId"],
        stateName: json["stateName"],
        showBtnChangeStateWo: json["showBtnChangeStateWo"],
      );

  Map<String, dynamic> toJson() => {
        "taskPlanId": taskPlanId,
        "constructionPlanId": constructionPlanId,
        "name": name,
        "status": status,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "isApprove": isApprove,
        "stateCode": stateCode,
        "woHcId": woHcId,
        "stateName": stateName,
        "showBtnChangeStateWo": showBtnChangeStateWo,
      };

  bool get showWO {
    const invalidStates = {'ASSIGN_CD', 'ACCEPT_CD', 'ASSIGN_FT', 'REJECT_FT'};
    return (!invalidStates.contains(stateCode) &&
            (showBtnChangeStateWo ?? false)) ||
        showBtnChangeStateWo == null ||
        showBtnChangeStateWo == false;
  }
}

class ElementDto {
  final int? taskPlanId;
  final int? constructionPlanId;
  final String? name;
  final int? status;
  final String? measure;

  ElementDto({
    this.taskPlanId,
    this.constructionPlanId,
    this.name,
    this.status,
    this.measure,
  });

  factory ElementDto.fromRawJson(String str) =>
      ElementDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ElementDto.fromJson(Map<String, dynamic> json) => ElementDto(
        taskPlanId: json["taskPlanId"],
        constructionPlanId: json["constructionPlanId"],
        name: json["name"],
        status: json["status"],
        measure: json["measure"],
      );

  Map<String, dynamic> toJson() => {
        "taskPlanId": taskPlanId,
        "constructionPlanId": constructionPlanId,
        "name": name,
        "status": status,
        "measure": measure,
      };
}
