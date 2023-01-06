class FindPartnerJson {
  List<Result>? result;
  bool? success;
  bool? unAuthorizedRequest;
  bool? bAbp;

  FindPartnerJson(
      {this.result, this.success, this.unAuthorizedRequest, this.bAbp});

  FindPartnerJson.fromJson(Map<String, dynamic> json) {
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
  int? prtnerId;
  int? cityId;
  int? age;
  int? gender;
  String? date;
  String? userName;
  String? cityName;
  int? id;

  Result(
      {this.prtnerId,
        this.cityId,
        this.age,
        this.gender,
        this.date,
        this.userName,
        this.cityName,
        this.id});

  Result.fromJson(Map<String, dynamic> json) {
    prtnerId = json['prtnerId'];
    cityId = json['cityId'];
    age = json['age'];
    gender = json['gender'];
    date = json['date'];
    userName = json['userName'];
    cityName = json['cityName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prtnerId'] = this.prtnerId;
    data['cityId'] = this.cityId;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['date'] = this.date;
    data['userName'] = this.userName;
    data['cityName'] = this.cityName;
    data['id'] = this.id;
    return data;
  }
}
