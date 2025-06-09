class WoRequest{
  int? page;
  int? pageSize;
  String? keySearch;
  String? woStateCode;
  String? contractCode;
  WoRequest({
    this.page = 1,
    this.pageSize = 50,
    this.keySearch,
    this.woStateCode,
    this.contractCode,
  });

  factory WoRequest.fromJson(Map<String, dynamic> json) {
    return WoRequest(
      page: json['page'],
      pageSize: json['pageSize'],
      keySearch: json['keySearch'],
      contractCode: json['contractCode'],
      woStateCode: json['woStateCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'keySearch': keySearch,
      'contractCode': contractCode,
      'woStateCode': woStateCode,
    };
  }
}