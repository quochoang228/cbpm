class FileDataDto {
  final String? path;
  final String? fileName;
  final String? data;
  final String? link;
  final String? type;

  FileDataDto({
    this.path,
    this.fileName,
    this.data,
    this.link,
    this.type,
  });

  factory FileDataDto.fromJson(Map<String, dynamic> json) {
    return FileDataDto(
      path: json['path'],
      fileName: json['fileName'],
      data: json['data'],
      link: json['link'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'fileName': fileName,
      'data': data,
      'link': link,
      'type': type,
    };
  }
}