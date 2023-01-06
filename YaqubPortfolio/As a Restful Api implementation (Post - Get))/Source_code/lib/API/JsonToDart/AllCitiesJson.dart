class AllCitiesJson {
  List<Result>? result;
  bool? success;
  bool? unAuthorizedRequest;
  bool? bAbp;

  AllCitiesJson(
      {this.result, this.success, this.unAuthorizedRequest, this.bAbp});

  AllCitiesJson.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    success = json['success'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class Result {
  int? countryId;
  String? countryName;
  String? name;
  int? id;

  Result({this.countryId, this.countryName, this.name, this.id});

  Result.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
