
import 'dart:convert';

AdvisorProfileModel advisorProfileModelFromJson(dynamic str) =>
    AdvisorProfileModel.fromJson(str);

String advisorProfileModelToJson(AdvisorProfileModel data) =>
    json.encode(data.toJson());

class AdvisorProfileModel {
  AdviserProfileData? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  AdvisorProfileModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory AdvisorProfileModel.fromJson(Map<String, dynamic> json) =>
      AdvisorProfileModel(
        data: json["data"] == null
            ? null
            : AdviserProfileData.fromJson(json["data"]),
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

class AdviserProfileData {
  dynamic id;
  String? avatar;
  String? description;
  String? fullName;
  String? info;
  String? experienceYear;
  List<Category>? category;
  List<Document>? document;
  dynamic adviceCount;
  String? rate;

  AdviserProfileData({
    this.id,
    this.avatar,
    this.description,
    this.fullName,
    this.info,
    this.experienceYear,
    this.category,
    this.document,
    this.adviceCount,
    this.rate,
  });

  factory AdviserProfileData.fromJson(Map<String, dynamic> json) =>
      AdviserProfileData(
        id: json["id"],
        avatar: json["avatar"],
        description: json["description"],
        fullName: json["full_name"],
        info: json["info"],
        experienceYear: json["experience_year"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        document: json["document"] == null
            ? []
            : List<Document>.from(
                json["document"]!.map((x) => Document.fromJson(x))),
        adviceCount: json["advice_count"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "description": description,
        "full_name": fullName,
        "info": info,
        "experience_year": experienceYear,
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "document": document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
        "advice_count": adviceCount,
        "rate": rate,
      };
}

class Category {
  dynamic id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Document {
  dynamic id;
  String? value;

  Document({
    this.id,
    this.value,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
