// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(dynamic str) => LoginModel.fromJson(str);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Data? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  LoginModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Data {
  int? id;
  String? avatar;
  String? email;
  String? description;
  String? lang;
  String? token;
  int? isNotification;
  String? fullName;
  String? mobile;
  String? userName;
  String? info;
  String? gender;
  Country? countryId;
  CityId? cityId;
  String? experienceYear;
  String? bankName;
  String? bankAccount;
  String? birthday;
  NationalityId? nationalityId;
  int? status;
  List<dynamic>? category;

  Data({
    this.id,
    this.avatar,
    this.email,
    this.description,
    this.lang,
    this.token,
    this.isNotification,
    this.fullName,
    this.mobile,
    this.userName,
    this.info,
    this.gender,
    this.countryId,
    this.cityId,
    this.experienceYear,
    this.bankName,
    this.bankAccount,
    this.birthday,
    this.nationalityId,
    this.status,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        avatar: json["avatar"],
        email: json["email"],
        description: json["description"],
        lang: json["lang"],
        token: json["token"],
        isNotification: json["is_notification"],
        fullName: json["full_name"],
        mobile: json["mobile"],
        userName: json["user_name"],
        info: json["info"],
        gender: json["gender"],
        countryId: json["country_id"] == null
            ? null
            : Country.fromJson(json["country_id"]),
        cityId:
            json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
        experienceYear: json["experience_year"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        birthday: json["birthday"],
        nationalityId: json["nationality_id"] == null
            ? null
            : NationalityId.fromJson(json["nationality_id"]),
        status: json["status"],
        category: json["category"] == null
            ? []
            : List<dynamic>.from(json["category"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "email": email,
        "description": description,
        "lang": lang,
        "token": token,
        "full_name": fullName,
        "mobile": mobile,
        "user_name": userName,
        "info": info,
        "gender": gender,
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
        "experience_year": experienceYear,
        "bank_name": bankName,
        "bank_account": bankAccount,
        "birthday": birthday,
        "nationality_id": nationalityId?.toJson(),
        "status": status,
        "category":
            category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
      };
}

class CityId {
  int? id;
  Country? country;
  String? name;

  CityId({
    this.id,
    this.country,
    this.name,
  });

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        id: json["id"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country?.toJson(),
        "name": name,
      };
}

class Country {
  int? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class NationalityId {
  int? id;
  String? name;
  String? logo;

  NationalityId({
    this.id,
    this.name,
    this.logo,
  });

  factory NationalityId.fromJson(Map<String, dynamic> json) => NationalityId(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
