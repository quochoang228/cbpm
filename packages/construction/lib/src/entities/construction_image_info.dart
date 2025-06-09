
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

  ConstructionImageInfo({
    this.utilAttachDocumentId,
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


  ConstructionImageInfo.fromJson(Map<String, dynamic> json) {
    utilAttachDocumentId = json['utilAttachDocumentId'];
    statusImage = json['statusImage'];
    imageName = json['imageName'];
    base64String = json['base64String'];
    filePath = json['filePath'];
    longtitude = json['longtitude'];
    latitude = json['latitude'];
    imagePath = json['imagePath'];
    type = json['type'];
    code = json['code'];
    name = json['name'];
    defaultSortField = json['defaultSortField'];
    messageColumn = json['messageColumn'];
    objectId = json['objectId'];
    description = json['description'];
    extension = json['extension'];
    fwmodelId = json['fwmodelId'];
    isDataServer = json['isDataServer'];
    srcUrl = json['srcUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['utilAttachDocumentId'] = utilAttachDocumentId;
    data['statusImage'] = statusImage;
    data['imageName'] = imageName;
    data['base64String'] = base64String;
    data['filePath'] = filePath;
    data['longtitude'] = longtitude;
    data['latitude'] = latitude;
    data['imagePath'] = imagePath;
    data['type'] = type;
    data['code'] = code;
    data['name'] = name;
    data['defaultSortField'] = defaultSortField;
    data['messageColumn'] = messageColumn;
    data['objectId'] = objectId;
    data['description'] = description;
    data['extension'] = extension;
    data['fwmodelId'] = fwmodelId;
    data['isDataServer'] = isDataServer;
    data['srcUrl'] = srcUrl;
    return data;
  }
}
