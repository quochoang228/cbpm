class ExtendWoRequest{
  int woId;
  String? reason;
  String? endDate;

  ExtendWoRequest({
    required this.woId,
    this.reason,
    this.endDate,
  });

  factory ExtendWoRequest.fromJson(Map<String, dynamic> json) {
    return ExtendWoRequest(
      woId: json['woId'],
      reason: json['reason'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'woId': woId,
      'reason': reason,
      'endDate': endDate,
    };
  }
}