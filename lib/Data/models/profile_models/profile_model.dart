
import 'dart:convert';

ProfileModel profileModelFromJson(dynamic str) => ProfileModel.fromJson(str);

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Data? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  ProfileModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  dynamic id;
  String? avatar;
  String? email;
  String? lang;
  String? token;
  String? fullName;
  String? mobile;
  String? gender;
  Country? countryId;
  CityId? cityId;
  NationalityId? nationalityId;
  dynamic status;

  Data({
    this.id,
    this.avatar,
    this.email,
    this.lang,
    this.token,
    this.fullName,
    this.mobile,
    this.gender,
    this.countryId,
    this.cityId,
    this.nationalityId,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        avatar: json["avatar"] ?? "",
        email: json["email"] ?? "",
        lang: json["lang"] ?? "",
        token: json["token"] ?? "",
        fullName: json["full_name"] ?? "",
        mobile: json["mobile"] ?? "",
        gender: json["gender"] ?? "",
        countryId: json["country_id"] == null
            ? null
            : Country.fromJson(json["country_id"]),
        cityId:
            json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
        nationalityId: json["nationality_id"] == null
            ? null
            : NationalityId.fromJson(json["nationality_id"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "email": email,
        "lang": lang,
        "token": token,
        "full_name": fullName,
        "mobile": mobile,
        "gender": gender,
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
        "nationality_id": nationalityId?.toJson(),
        "status": status,
      };
}

class CityId {
  dynamic id;
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
  dynamic id;
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
  dynamic id;
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
