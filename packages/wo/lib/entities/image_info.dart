class ConstructionImageInfo {
  int? utilAttachDocumentId;
  int? statusImage;
  String? imageName;
  String? base64String;
  String? filePath;
  double? longtitude;
  double? latitude;
  String? imagePath;
  String? type;
  String? code;
  String? name;
  bool? isDataServer;
  String? defaultSortField;
  int? messageColumn;
  int? objectId;
  String? description;
  String? extension;
  int? fwmodelId;
  String? srcUrl;

  ConstructionImageInfo(
      {this.utilAttachDocumentId,
      this.imageName,
      this.statusImage,
      this.base64String,
      this.filePath,
      this.longtitude,
      this.latitude,
      this.imagePath,
      this.type,
      this.code,
      this.name,
      this.defaultSortField,
      this.messageColumn,
      this.objectId,
      this.description,
      this.fwmodelId,
      this.extension,
      this.isDataServer = false,
      this.srcUrl,
      });

  factory ConstructionImageInfo.fromJson(Map<String, dynamic> json) {
    return ConstructionImageInfo(
      utilAttachDocumentId: json['utilAttachDocumentId'],
      statusImage: json['statusImage'],
      imageName: json['imageName'],
      base64String: json['base64String'],
      filePath: json['filePath'],
      longtitude: (json['longtitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      imagePath: json['imagePath'],
      type: json['type'],
      code: json['code'],
      name: json['name'],
      defaultSortField: json['defaultSortField'],
      messageColumn: json['messageColumn'],
      objectId: json['objectId'],
      description: json['description'],
      extension: json['extension'],
      fwmodelId: json['fwmodelId'],
      srcUrl: json['srcUrl'],
      isDataServer: json['isDataServer'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilAttachDocumentId': utilAttachDocumentId,
      'statusImage': statusImage,
      'imageName': imageName,
      'base64String': base64String,
      'filePath': filePath,
      'longtitude': longtitude,
      'latitude': latitude,
      'imagePath': imagePath,
      'type': type,
      'code': code,
      'name': name,
      'defaultSortField': defaultSortField,
      'messageColumn': messageColumn,
      'objectId': objectId,
      'description': description,
      'extension': extension,
      'fwmodelId': fwmodelId,
      'srcUrl': srcUrl,
      'isDataServer': isDataServer,
    };
  }
}
