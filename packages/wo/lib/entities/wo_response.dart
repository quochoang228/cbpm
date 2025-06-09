class WoResponse {
  WoResponse({
    required this.woHCId,
    this.woCode,
    this.woName,
    this.contractCode,
    this.constructionCode,
    this.constructionName,
    this.taskPlanIds,
    this.taskPlanNames,
    this.woStateName,
    this.moneyValue,
    this.createdUserFullName,
    this.deadlineDate,
    this.isFTId,
    this.cdLevel2,
    this.woTypeCode,
    this.contractBranch,
    this.contractTypeO,
  });

  final int woHCId;
  final String? woCode;
  final String? woTypeCode;
  final String? woName;
  final String? contractCode;
  final String? constructionCode;
  final String? constructionName;
  final String? taskPlanIds;
  final String? taskPlanNames;
  final String? woStateName;
  final double? moneyValue;
  final String? createdUserFullName;
  final String? deadlineDate;
  final int? isFTId;
  final int? cdLevel2;
  final String? contractBranch;
  final int? contractTypeO;

  bool get hideExtendButton {
    return ((woTypeCode == 'KHAC_PHUC') ||
        (woTypeCode == 'WO_LAY_HANG_CDT_CAP'));
  }

  factory WoResponse.fromJson(Map<String, dynamic> json) {
    return WoResponse(
      woHCId: json['woHCId'],
      woCode: json['woCode'],
      woName: json['woName'],
      contractCode: json['contractCode'],
      constructionCode: json['constructionCode'],
      constructionName: json['constructionName'],
      taskPlanIds: json['taskPlanIds'],
      taskPlanNames: json['taskPlanNames'],
      woStateName: json['woStateName'],
      moneyValue: (json['moneyValue'] as num?)?.toDouble(),
      createdUserFullName: json['createdUserFullName'],
      deadlineDate: json['deadlineDate'],
      isFTId: json['isFTId'],
      cdLevel2: json['cdLevel2'],
      woTypeCode: json['woTypeCode'],
      contractBranch: json['contractBranch'],
      contractTypeO: json['contractTypeO'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'woHCId': woHCId,
      'woCode': woCode,
      'woName': woName,
      'contractCode': contractCode,
      'constructionCode': constructionCode,
      'constructionName': constructionName,
      'taskPlanIds': taskPlanIds,
      'taskPlanNames': taskPlanNames,
      'woStateName': woStateName,
      'moneyValue': moneyValue,
      'createdUserFullName': createdUserFullName,
      'deadlineDate': deadlineDate,
      'isFTId': isFTId,
      'cdLevel2': cdLevel2,
      'woTypeCode': woTypeCode,
      'contractBranch': contractBranch,
      'contractTypeO': contractTypeO,
    };
  }
}