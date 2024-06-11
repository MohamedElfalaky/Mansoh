import 'dart:convert';

AboutUsModel aboutUsModelFromJson(dynamic str) =>
    AboutUsModel.fromJson(str);

String aboutUsModelToJson(AboutUsModel data) =>
    json.encode(data.toJson());

class AboutUsModel {
  Data? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  AboutUsModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      AboutUsModel(
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
  String? name;
  String? description;

  Data({
    this.id,
    this.name,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
