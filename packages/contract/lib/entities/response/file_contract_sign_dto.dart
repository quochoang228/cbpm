class FileContractSignDto {
  String? filePath;
  String? name;
  String? code;
  int? objectId;

  FileContractSignDto({
    this.filePath,
    this.name,
    this.code,
    this.objectId,
  });

  factory FileContractSignDto.fromJson(Map<String, dynamic> json) {
    return FileContractSignDto(
      filePath: json['filePath'],
      name: json['name'],
      code: json['code'],
      objectId: json['objectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filePath': filePath,
      'name': name,
      'code': code,
      'objectId': objectId,
    };
  }
}
