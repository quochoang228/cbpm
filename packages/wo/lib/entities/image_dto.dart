import 'dart:typed_data';

class ImageDto {
  ImageDto({
    this.utilAttachDocumentId,
    this.imageName,
    this.base64String,
    this.filePath,
    this.longitude,
    this.latitude,
    this.imagePath,
    this.type,
    this.name,
    this.fileName,
    this.id,
    this.uint8list,
    this.isDataServer = false,
    this.code,
    this.woId,
    this.extension,
  });

  int? utilAttachDocumentId;
  String? imageName;
  String? base64String;
  String? filePath;
  double? longitude;
  double? latitude;
  String? imagePath;
  String? type;
  String? name;
  String? fileName;
  bool? isDataServer;
  int? id;
  Uint8List? uint8list;
  String? code;
  int? woId;
  String? extension;

  ImageDto.fromJson(Map<String, dynamic> json) {
    utilAttachDocumentId = json['utilAttachDocumentId'];
    imageName = json['imageName'];
    base64String = json['base64String'];
    filePath = json['filePath'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    imagePath = json['imagePath'];
    type = json['type'];
    name = json['name'];
    fileName = json['fileName'];
    code = json['code'];
    woId = json['woId'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['utilAttachDocumentId'] = this.utilAttachDocumentId;
    data['imageName'] = this.imageName;
    data['base64String'] = this.base64String;
    data['filePath'] = this.filePath;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['imagePath'] = this.imagePath;
    data['type'] = this.type;
    data['name'] = this.name;
    data['fileName'] = this.fileName;
    data['code'] = this.code;
    data['woId'] = this.woId;
    data['extension'] = this.extension;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      // 'utilAttachDocumentId': this.utilAttachDocumentId,
      // 'imageName': this.imageName,
      // 'status': this.status,
      // 'base64String': this.base64String,
      // 'filePath': this.filePath,
      'longitude': this.longitude,
      'latitude': this.latitude,
      'imagePath': this.imagePath,
      // 'type': this.type,
      // 'name': this.name,
      // 'uint8list': this.uint8list,
    };
  }

  factory ImageDto.fromMap(Map<String, dynamic> json) => new ImageDto(
        id: json["id"],
        imagePath: json["imagePath"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        uint8list: json["uint8list"],
        name: json["name"],
      );

  @override
  String toString() {
    return 'ConstructionImageUpdate{utilAttachDocumentId: $utilAttachDocumentId, imageName: $imageName, base64String: $base64String, filePath: $filePath, longitude: $longitude, latitude: $latitude, imagePath: $imagePath, type: $type, name: $name, isDataServer: $isDataServer, id: $id, uint8list: $uint8list}';
  }
}
