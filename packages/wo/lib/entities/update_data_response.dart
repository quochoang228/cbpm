class UpdateDataResponse {
  bool? success;
  String? message;
  int? status;

  UpdateDataResponse({
    this.success,
    this.message,
    this.status,
  });

  factory UpdateDataResponse.fromJson(Map<String, dynamic> json) {
    return UpdateDataResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
    };
  }
}
