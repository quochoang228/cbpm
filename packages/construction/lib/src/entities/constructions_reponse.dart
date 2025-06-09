import 'dart:convert';

import 'construction_dto.dart';

class ConstructionsReponse {
  final List<ConstructionDto>? data;

  ConstructionsReponse({
    this.data,
  });

  factory ConstructionsReponse.fromRawJson(String str) =>
      ConstructionsReponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConstructionsReponse.fromJson(Map<String, dynamic> json) =>
      ConstructionsReponse(
        data: json["data"] == null
            ? []
            : List<ConstructionDto>.from(
                json["data"]!.map((x) => ConstructionDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ConstructionDetailResponseData {
  final ConstructionDto? data;

  ConstructionDetailResponseData({
    this.data,
  });

  factory ConstructionDetailResponseData.fromRawJson(String str) =>
      ConstructionDetailResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConstructionDetailResponseData.fromJson(Map<String, dynamic> json) =>
      ConstructionDetailResponseData(
        data: json["data"] == null
            ? null
            : ConstructionDto.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
