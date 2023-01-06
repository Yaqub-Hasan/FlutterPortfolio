class DialogJson {
  Result? result;
  bool? success;
  bool? unAuthorizedRequest;
  bool? bAbp;

  DialogJson({this.result, this.success, this.unAuthorizedRequest, this.bAbp});

  DialogJson.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    success = json['success'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['success'] = this.success;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class Result {
  String? id;
  String? lastMessageTime;
  List<Dialogs>? dialogs;

  Result({this.id, this.lastMessageTime, this.dialogs});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastMessageTime = json['lastMessageTime'];
    if (json['dialogs'] != null) {
      dialogs = <Dialogs>[];
      json['dialogs'].forEach((v) {
        dialogs!.add(new Dialogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastMessageTime'] = this.lastMessageTime;
    if (this.dialogs != null) {
      data['dialogs'] = this.dialogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dialogs {
  int? who;
  String? message;
  String? chatid;
  String? time;
  int? id;

  Dialogs({this.who, this.message, this.chatid, this.time, this.id});

  Dialogs.fromJson(Map<String, dynamic> json) {
    who = json['who'];
    message = json['message'];
    chatid = json['chatid'];
    time = json['time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['who'] = this.who;
    data['message'] = this.message;
    data['chatid'] = this.chatid;
    data['time'] = this.time;
    data['id'] = this.id;
    return data;
  }
}
