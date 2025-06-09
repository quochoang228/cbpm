class FileEntity {
  final int? attachmentId;
  final String? fileName;
  final String? fileId;
  final int? objectId;
  final String? createdName;
  final String? createdBy;
  final String? createdTime;
  final String? checkSum;

  FileEntity({
    this.attachmentId,
    this.fileName,
    this.fileId,
    this.objectId,
    this.createdName,
    this.createdBy,
    this.createdTime,
    this.checkSum,

  });

  factory FileEntity.fromJson(Map<String, dynamic> json) => FileEntity(
    attachmentId: json["attachmentId"],
    fileName: json["fileName"],
    fileId: json["fileId"],
    objectId: json["objectId"],
    createdName: json["createdName"],
    createdBy: json["createdBy"],
    createdTime: json["createdTime"],
    checkSum: json["checkSum"],
  );
}