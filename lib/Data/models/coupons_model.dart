class CouponsModel {
  List<Data>? data;
  dynamic status;
  String? message;

  CouponsModel({this.data, this.status, this.message});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  dynamic id;
  String? code;
  dynamic balance;

  Data({this.id, this.code, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['balance'] = balance;
    return data;
  }
}
