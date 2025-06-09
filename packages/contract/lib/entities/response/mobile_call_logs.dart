class MobileCallLogsResponse{
  List<MobileCallLogs>? aioAffectLogList;
  List<MobileCallLogs>? mobileCallLogList;
  List<MobileCallLogs>? listActionLog;
  List<MobileCallLogs>? listCallLog;
  MobileCallLogsResponse({
    this.aioAffectLogList,
    this.mobileCallLogList,
    this.listActionLog,
    this.listCallLog,
  });

  factory MobileCallLogsResponse.fromJson(Map<String, dynamic> json) {
    return MobileCallLogsResponse(
      aioAffectLogList: (json['aioAffectLogList'] as List?)
          ?.map((e) => MobileCallLogs.fromJson(e))
          .toList(),
      mobileCallLogList: (json['mobileCallLogList'] as List?)
          ?.map((e) => MobileCallLogs.fromJson(e))
          .toList(),
      listActionLog: (json['listActionLog'] as List?)
          ?.map((e) => MobileCallLogs.fromJson(e))
          .toList(),
      listCallLog: (json['listCallLog'] as List?)
          ?.map((e) => MobileCallLogs.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aioAffectLogList': aioAffectLogList?.map((e) => e.toJson()).toList(),
      'mobileCallLogList': mobileCallLogList?.map((e) => e.toJson()).toList(),
      'listActionLog': listActionLog?.map((e) => e.toJson()).toList(),
      'listCallLog': listCallLog?.map((e) => e.toJson()).toList(),
    };
  }
}

class MobileCallLogs {
  int? objectId;
  String? tableName;
  String? functionName;
  String? note;
  int? createdUser;
  int? createdDate;
  String? createdUserStr;
  String? actionTypeStr;

  ///Lich su cuoc goi
  int? startTime;
  int? endTime;
  int? ringingTime;
  int? callStatus;
  int? callType;
  String? contentLog;
  String? actionUserName;

  String? oldValue;
  String? newValue;

  MobileCallLogs({
    this.tableName,
    this.objectId,
    this.note,
    this.createdDate,
    this.actionTypeStr,
    this.createdUser,
    this.createdUserStr,
    this.functionName,
    this.endTime,
    this.ringingTime,
    this.startTime,
    this.callType,
    this.actionUserName,
    this.callStatus,
    this.contentLog,
    this.newValue,
    this.oldValue
  });

  factory MobileCallLogs.fromJson(Map<String, dynamic> json) {
    return MobileCallLogs(
      objectId: json['objectId'],
      tableName: json['tableName'],
      functionName: json['functionName'],
      note: json['note'],
      createdUser: json['createdUser'],
      createdDate: json['createdDate'],
      createdUserStr: json['createdUserStr'],
      actionTypeStr: json['actionTypeStr'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      ringingTime: json['ringingTime'],
      callStatus: json['callStatus'],
      callType: json['callType'],
      contentLog: json['contentLog'],
      actionUserName: json['actionUserName'],
      oldValue: json['oldValue'],
      newValue: json['newValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'tableName': tableName,
      'functionName': functionName,
      'note': note,
      'createdUser': createdUser,
      'createdDate': createdDate,
      'createdUserStr': createdUserStr,
      'actionTypeStr': actionTypeStr,
      'startTime': startTime,
      'endTime': endTime,
      'ringingTime': ringingTime,
      'callStatus': callStatus,
      'callType': callType,
      'contentLog': contentLog,
      'actionUserName': actionUserName,
      'oldValue': oldValue,
      'newValue': newValue,
    };
  }
}