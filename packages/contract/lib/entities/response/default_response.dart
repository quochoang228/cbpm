class ListDataResponse<T> {
  int? status;
  String? message;
  int? totalRecord;
  List<T>? data;

  ListDataResponse({
    this.status,
    this.message,
    this.data,
    this.totalRecord,
  });

  factory ListDataResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return ListDataResponse<T>(
      status: json['status'],
      message: json['message'],
      totalRecord: json['totalRecord'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'status': status,
      'message': message,
      'totalRecord': totalRecord,
      'data': data?.map(toJsonT).toList(),
    };
  }
}

class DataResponse<T> {
  int? status;
  String? message;
  T? data;

  DataResponse({this.status, this.message, this.data});

  factory DataResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return DataResponse<T>(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'status': status,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}

class NoneDataResponse {
  int? status;
  String? message;
  dynamic data;
  Response? response;

  NoneDataResponse({this.status, this.message, this.data, this.response});

  factory NoneDataResponse.fromJson(Map<String, dynamic> json) {
    return NoneDataResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      response: json['response'] != null
          ? Response.fromJson(json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
      'response': response?.toJson(),
    };
  }
}

class Response {
  String? typeUser;

  Response({this.typeUser});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      typeUser: json['typeUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeUser': typeUser,
    };
  }
}
