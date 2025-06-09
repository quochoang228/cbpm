class OtpDTO {
  String? otpCode;
  int? duration;
  int? otpId;

  OtpDTO({
    this.otpCode,
    this.duration,
    this.otpId,
  });

  factory OtpDTO.fromJson(Map<String, dynamic> json) {
    return OtpDTO(
      otpCode: json['otpCode'] as String?,
      duration: json['duration'] as int?,
      otpId: json['otpId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otpCode': otpCode,
      'otpId': otpId,
      'duration': duration,
    };
  }
}
