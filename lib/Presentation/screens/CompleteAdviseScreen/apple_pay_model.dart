class ApplePayModel {
  Data? data;
  int? status;
  String? message;

  ApplePayModel({this.data, this.status, this.message,});

  ApplePayModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;

    return data;
  }
}

class Data {
  int? adviceId;
  String? paymentUrl;

  Data({this.adviceId, this.paymentUrl});

  Data.fromJson(Map<String, dynamic> json) {
    adviceId = json['advice_id'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advice_id'] = adviceId;
    data['payment_url'] = paymentUrl;
    return data;
  }
}
