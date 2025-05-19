class SignDataResponse {
  bool? result;
  String? message;

  SignDataResponse({
    this.result,
    this.message,
  });

  factory SignDataResponse.fromJson(Map<String, dynamic> json) {
    return SignDataResponse(
      result: json['result'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }
}
