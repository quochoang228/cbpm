class CustomerInfo {
  final String? fullName;
  final String? phoneNumber;
  final String? position;
  final String? department;

  CustomerInfo({
    this.fullName,
    this.phoneNumber,
    this.position,
    this.department,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      position: json['position'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'position': position,
      'department': department,
    };
  }
}
