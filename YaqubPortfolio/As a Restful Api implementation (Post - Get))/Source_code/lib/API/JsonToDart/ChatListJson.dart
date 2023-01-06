class ChatsListJson {
  List<Result>? result;
  bool? success;
  bool? unAuthorizedRequest;
  bool? bAbp;

  ChatsListJson(
      {this.result, this.success, this.unAuthorizedRequest, this.bAbp});

  ChatsListJson.fromJson(Map<String, dynamic> json) {
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
  String? id;
  int? accountId;
  String? fullName;
  int? contactId;
  String? lastMessage;
  String? lastMessageTime;
  List<Dialogs>? dialogs;

  Result(
      {this.id,
        this.accountId,
        this.fullName,
        this.contactId,
        this.lastMessage,
        this.lastMessageTime,
        this.dialogs});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    fullName = json['fullName'];
    contactId = json['contactId'];
    lastMessage = json['lastMessage'];
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
    data['accountId'] = this.accountId;
    data['fullName'] = this.fullName;
    data['contactId'] = this.contactId;
    data['lastMessage'] = this.lastMessage;
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
