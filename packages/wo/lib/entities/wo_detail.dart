import 'package:wo/entities/image_dto.dart';

import 'cus_info.dart';
import 'image_info.dart';
import 'question_entity.dart';

class WoDetail {
  WoDetail({
    this.woHcId,
    this.woCode,
    this.woName,
    this.state,
    this.constructionId,
    this.userCreated,
    this.createDateString,
    this.finishDateString,
    this.qoutaTime,
    this.cdLevel1,
    this.cdLevel2,
    this.cdLevel3,
    this.ftId,
    this.acceptTimeString,
    this.startTimeString,
    this.moneyValue,
    this.contractId,
    this.constructionCode,
    this.contractCode,
    this.cdLevel1Name,
    this.cdLevel2Name,
    this.ftName,
    this.ftEmail,
    this.taskPlanIds,
    this.taskPlanNames,
    this.woWorkLogs,
    this.woChecklistDTOList,
    this.woMappingChecklistDTOList,
    this.stateName,
    this.listImage,
    this.checkLists,
    this.transferValue,
    this.transferDate,
    this.isRoleUserEdit,
    this.contactName,
    this.contactPhone,
    this.productAddress,
    this.woProductCdtDTOS,
    this.woMappingAttachDTOList,
    this.woTypeCode,
    this.handOverFile,
    this.handoverUseDateReality,
    this.b2BB2C,
    this.finishDateKhacPhuc,
    this.bpKhacPhuc,
    this.warehouseDispatchCdtCode,
    this.isCd,
    this.listFileKsCLDV,
    this.listQuestion,
    this.cus_info,
    this.type_pks,
    this.reasonRejectKsCLDV,
    this.needUploadFileKsCldv,
  });

  final int? woHcId;
  final String? woCode;
  final String? woName;
  final String? state;
  final int? constructionId;
  final String? userCreated;
  final String? createDateString;
  final String? finishDateString;
  final int? qoutaTime;
  final int? cdLevel1;
  final int? cdLevel2;
  final int? cdLevel3;
  final int? ftId;
  final String? acceptTimeString;
  final String? startTimeString;
  final double? moneyValue;
  final int? contractId;
  final String? constructionCode;
  final String? contractCode;
  final String? cdLevel1Name;
  final String? cdLevel2Name;
  final String? ftName;
  final String? ftEmail;
  final String? taskPlanIds;
  final String? taskPlanNames;
  var woWorkLogs;
  var woChecklistDTOList;
  var woMappingChecklistDTOList;
  List<ChecklistDto>? checkLists;
  final String? stateName;
  final List<ImageDto>? listImage;
  final List<ImageDto>? woMappingAttachDTOList;
  double? transferValue;
  DateTime? transferDate;
  int? isRoleUserEdit;
  final List<WoProductCdtDTO>? woProductCdtDTOS;
  String? contactName;
  String? contactPhone;
  String? productAddress;
  dynamic woTypeCode;
  List<ConstructionImageInfo>? handOverFile;
  int? handoverUseDateReality;
  String? b2BB2C;
  String? finishDateKhacPhuc;
  String? bpKhacPhuc;
  bool? isCd;
  String? warehouseDispatchCdtCode;
  List<ConstructionImageInfo>? listFileKsCLDV;
  bool? needUploadFileKsCldv;
  List<QuestionEntity>? listQuestion;
  CustomerInfo? cus_info;
  String? type_pks;
  String? reasonRejectKsCLDV;

  factory WoDetail.fromJson(Map<String, dynamic> json) => WoDetail(
    woHcId: json['woHcId'],
    woCode: json['woCode'],
    woName: json['woName'],
    state: json['state'],
    constructionId: json['constructionId'],
    userCreated: json['userCreated'],
    createDateString: json['createDateString'],
    finishDateString: json['finishDateString'],
    qoutaTime: json['qoutaTime'],
    cdLevel1: json['cdLevel1'],
    cdLevel2: json['cdLevel2'],
    cdLevel3: json['cdLevel3'],
    ftId: json['ftId'],
    acceptTimeString: json['acceptTimeString'],
    startTimeString: json['startTimeString'],
    moneyValue: (json['moneyValue'] as num?)?.toDouble(),
    contractId: json['contractId'],
    constructionCode: json['constructionCode'],
    contractCode: json['contractCode'],
    cdLevel1Name: json['cdLevel1Name'],
    cdLevel2Name: json['cdLevel2Name'],
    ftName: json['ftName'],
    ftEmail: json['ftEmail'],
    taskPlanIds: json['taskPlanIds'],
    taskPlanNames: json['taskPlanNames'],
    woWorkLogs: json['woWorkLogs'],
    woChecklistDTOList: json['woChecklistDTOList'],
    woMappingChecklistDTOList: json['woMappingChecklistDTOList'],
    checkLists: (json['checkLists'] as List<dynamic>?)
        ?.map((e) => ChecklistDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    stateName: json['stateName'],
    listImage: (json['listImage'] as List<dynamic>?)
        ?.map((e) => ImageDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    woMappingAttachDTOList: (json['woMappingAttachDTOList'] as List<dynamic>?)
        ?.map((e) => ImageDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    transferValue: (json['transferValue'] as num?)?.toDouble(),
    transferDate: json['transferDate'] != null ? DateTime.tryParse(json['transferDate']) : null,
    isRoleUserEdit: json['isRoleUserEdit'],
    woProductCdtDTOS: (json['woProductCdtDTOS'] as List<dynamic>?)
        ?.map((e) => WoProductCdtDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    contactName: json['contactName'],
    contactPhone: json['contactPhone'],
    productAddress: json['productAddress'],
    woTypeCode: json['woTypeCode'],
    handOverFile: (json['handOverFile'] as List<dynamic>?)
        ?.map((e) => ConstructionImageInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    handoverUseDateReality: json['handoverUseDateReality'],
    b2BB2C: json['b2BB2C'],
    finishDateKhacPhuc: json['finishDateKhacPhuc'],
    bpKhacPhuc: json['bpKhacPhuc'],
    isCd: json['isCd'],
    warehouseDispatchCdtCode: json['warehouseDispatchCdtCode'],
    listFileKsCLDV: (json['listFileKsCLDV'] as List<dynamic>?)
        ?.map((e) => ConstructionImageInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    needUploadFileKsCldv: json['needUploadFileKsCldv'],
    listQuestion: (json['listQuestion'] as List<dynamic>?)
        ?.map((e) => QuestionEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    cus_info: json['cus_info'] != null ? CustomerInfo.fromJson(json['cus_info']) : null,
    type_pks: json['type_pks'],
    reasonRejectKsCLDV: json['reasonRejectKsCLDV'],
  );

  Map<String, dynamic> toJson() => {
    'woHcId': woHcId,
    'woCode': woCode,
    'woName': woName,
    'state': state,
    'constructionId': constructionId,
    'userCreated': userCreated,
    'createDateString': createDateString,
    'finishDateString': finishDateString,
    'qoutaTime': qoutaTime,
    'cdLevel1': cdLevel1,
    'cdLevel2': cdLevel2,
    'cdLevel3': cdLevel3,
    'ftId': ftId,
    'acceptTimeString': acceptTimeString,
    'startTimeString': startTimeString,
    'moneyValue': moneyValue,
    'contractId': contractId,
    'constructionCode': constructionCode,
    'contractCode': contractCode,
    'cdLevel1Name': cdLevel1Name,
    'cdLevel2Name': cdLevel2Name,
    'ftName': ftName,
    'ftEmail': ftEmail,
    'taskPlanIds': taskPlanIds,
    'taskPlanNames': taskPlanNames,
    'woWorkLogs': woWorkLogs,
    'woChecklistDTOList': woChecklistDTOList,
    'woMappingChecklistDTOList': woMappingChecklistDTOList,
    'checkLists': checkLists?.map((e) => e.toJson()).toList(),
    'stateName': stateName,
    'listImage': listImage?.map((e) => e.toJson()).toList(),
    'woMappingAttachDTOList': woMappingAttachDTOList?.map((e) => e.toJson()).toList(),
    'transferValue': transferValue,
    'transferDate': transferDate?.toIso8601String(),
    'isRoleUserEdit': isRoleUserEdit,
    'woProductCdtDTOS': woProductCdtDTOS?.map((e) => e.toJson()).toList(),
    'contactName': contactName,
    'contactPhone': contactPhone,
    'productAddress': productAddress,
    'woTypeCode': woTypeCode,
    'handOverFile': handOverFile?.map((e) => e.toJson()).toList(),
    'handoverUseDateReality': handoverUseDateReality,
    'b2BB2C': b2BB2C,
    'finishDateKhacPhuc': finishDateKhacPhuc,
    'bpKhacPhuc': bpKhacPhuc,
    'isCd': isCd,
    'warehouseDispatchCdtCode': warehouseDispatchCdtCode,
    'listFileKsCLDV': listFileKsCLDV?.map((e) => e.toJson()).toList(),
    'needUploadFileKsCldv': needUploadFileKsCldv,
    'listQuestion': listQuestion?.map((e) => e.toJson()).toList(),
    'cus_info': cus_info?.toJson(),
    'type_pks': type_pks,
    'reasonRejectKsCLDV': reasonRejectKsCLDV,
  };

}

class ChecklistDto {
  int? id;
  int? woId;
  int? checkListId;
  String? state;
  int? status;
  String? quantityByDate;
  String? name;
  int? numImgRequire;
  String? tthqResult;
  String? dbhtVuong;
  String? stateName;
  List<ProfileCollaboratorDto>? lstCtvs;
  String? woType;
  int? contractId;
  String? contractCode;
  double? contractValue;
  double? commissionPercent;
  double? commissionValue;
  String? pickUpDateStr;
  String? reportCode;

  ChecklistDto({
    this.id,
    this.woId,
    this.checkListId,
    this.state,
    this.status,
    this.quantityByDate,
    this.name,
    this.numImgRequire,
    this.tthqResult,
    this.dbhtVuong,
    this.stateName,
    this.lstCtvs,
    this.woType,
    this.contractId,
    this.contractCode,
    this.contractValue,
    this.commissionPercent,
    this.commissionValue,
    this.pickUpDateStr,
    this.reportCode,
  });

  factory ChecklistDto.fromJson(Map<String, dynamic> json) => ChecklistDto(
    id: json['id'],
    woId: json['woId'],
    checkListId: json['checkListId'],
    state: json['state'],
    status: json['status'],
    quantityByDate: json['quantityByDate'],
    name: json['name'],
    numImgRequire: json['numImgRequire'],
    tthqResult: json['tthqResult'],
    dbhtVuong: json['dbhtVuong'],
    stateName: json['stateName'],
    lstCtvs: (json['lstCtvs'] as List<dynamic>?)
        ?.map((e) => ProfileCollaboratorDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    woType: json['woType'],
    contractId: json['contractId'],
    contractCode: json['contractCode'],
    contractValue: (json['contractValue'] as num?)?.toDouble(),
    commissionPercent: (json['commissionPercent'] as num?)?.toDouble(),
    commissionValue: (json['commissionValue'] as num?)?.toDouble(),
    pickUpDateStr: json['pickUpDateStr'],
    reportCode: json['reportCode'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'woId': woId,
    'checkListId': checkListId,
    'state': state,
    'status': status,
    'quantityByDate': quantityByDate,
    'name': name,
    'numImgRequire': numImgRequire,
    'tthqResult': tthqResult,
    'dbhtVuong': dbhtVuong,
    'stateName': stateName,
    'lstCtvs': lstCtvs?.map((e) => e.toJson()).toList(),
    'woType': woType,
    'contractId': contractId,
    'contractCode': contractCode,
    'contractValue': contractValue,
    'commissionPercent': commissionPercent,
    'commissionValue': commissionValue,
    'pickUpDateStr': pickUpDateStr,
    'reportCode': reportCode,
  };
}

class ProfileCollaboratorDto {
  int? id;
  int? collaboratorsId;
  String? collaboratorsCode;
  String? collaboratorsName;
  String? collaboratorsPhone;
  String? note;
  int? roseContractCtv;
  double? commissionValueCtv;
  int? status;
  int? cntContractId;

  ProfileCollaboratorDto({
    this.id,
    this.collaboratorsId,
    this.collaboratorsCode,
    this.collaboratorsName,
    this.collaboratorsPhone,
    this.note,
    this.roseContractCtv,
    this.commissionValueCtv,
    this.status,
    this.cntContractId,
  });

  factory ProfileCollaboratorDto.fromJson(Map<String, dynamic> json) => ProfileCollaboratorDto(
    id: json['id'],
    collaboratorsId: json['collaboratorsId'],
    collaboratorsCode: json['collaboratorsCode'],
    collaboratorsName: json['collaboratorsName'],
    collaboratorsPhone: json['collaboratorsPhone'],
    note: json['note'],
    roseContractCtv: json['roseContractCtv'],
    commissionValueCtv: (json['commissionValueCtv'] as num?)?.toDouble(),
    status: json['status'],
    cntContractId: json['cntContractId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'collaboratorsId': collaboratorsId,
    'collaboratorsCode': collaboratorsCode,
    'collaboratorsName': collaboratorsName,
    'collaboratorsPhone': collaboratorsPhone,
    'note': note,
    'roseContractCtv': roseContractCtv,
    'commissionValueCtv': commissionValueCtv,
    'status': status,
    'cntContractId': cntContractId,
  };

}

class WoProductCdtDTO {
  int? woProductCdtId;
  int? woHcId;
  String? productCode;
  String? productName;
  String? unit;
  double? amount;
  double? realAmount;
  double? realAmountNew;
  int? createdUser;
  int? createdDate;
  bool? isNotEdit;
  List<String>? serialList;
  String? isSerial;
  String? warehouseDispatchCdtCode;
  int? updatedDate;
  String? serial;
  int? goodsId;
  double? price;
  int? updatedUser;
  bool? isNew;

  WoProductCdtDTO({
    this.woProductCdtId,
    this.woHcId,
    this.productCode,
    this.productName,
    this.unit,
    this.amount,
    this.createdUser,
    this.createdDate,
    this.realAmount,
    this.isNotEdit,
    this.serialList,
    this.isSerial,
    this.goodsId,
    this.warehouseDispatchCdtCode,
    this.price,
    this.updatedDate,
    this.updatedUser,
    this.serial,
    this.isNew = false,
  });

  factory WoProductCdtDTO.fromJson(Map<String, dynamic> json) => WoProductCdtDTO(
    woProductCdtId: json['woProductCdtId'],
    woHcId: json['woHcId'],
    productCode: json['productCode'],
    productName: json['productName'],
    unit: json['unit'],
    amount: (json['amount'] as num?)?.toDouble(),
    realAmount: (json['realAmount'] as num?)?.toDouble(),
    createdUser: json['createdUser'],
    createdDate: json['createdDate'],
    isNotEdit: json['isNotEdit'],
    serialList: (json['serialList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    isSerial: json['isSerial'],
    warehouseDispatchCdtCode: json['warehouseDispatchCdtCode'],
    updatedDate: json['updatedDate'],
    serial: json['serial'],
    goodsId: json['goodsId'],
    price: (json['price'] as num?)?.toDouble(),
    updatedUser: json['updatedUser'],
    isNew: json['isNew'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'woProductCdtId': woProductCdtId,
    'woHcId': woHcId,
    'productCode': productCode,
    'productName': productName,
    'unit': unit,
    'amount': amount,
    'realAmount': realAmount,
    'createdUser': createdUser,
    'createdDate': createdDate,
    'isNotEdit': isNotEdit,
    'serialList': serialList,
    'isSerial': isSerial,
    'warehouseDispatchCdtCode': warehouseDispatchCdtCode,
    'updatedDate': updatedDate,
    'serial': serial,
    'goodsId': goodsId,
    'price': price,
    'updatedUser': updatedUser,
    'isNew': isNew,
  };
}
