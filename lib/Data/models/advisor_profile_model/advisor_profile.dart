// To parse this JSON data, do
//
//     final advisorProfileModel = advisorProfileModelFromJson(jsonString);

import 'dart:convert';

AdvisorProfileModel advisorProfileModelFromJson(dynamic str) =>
    AdvisorProfileModel.fromJson(str);

String advisorProfileModelToJson(AdvisorProfileModel data) =>
    json.encode(data.toJson());

class AdvisorProfileModel {
  AdviserProfileData? data;
  int? status;
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
        data: json["data"] == null ? null : AdviserProfileData.fromJson(json["data"]),
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
  int? id;
  String? avatar;
  String? description;
  String? fullName;
  String? rate;
  int? adviceCount;
  String? info;
  String? experienceYear;
  List<Category>? category;
  List<Document>? document;

  AdviserProfileData({
    this.id,
    this.avatar,
    this.description,
    this.fullName,
    this.rate,
    this.adviceCount,
    this.info,
    this.experienceYear,
    this.category,
    this.document,
  });

  factory AdviserProfileData.fromJson(Map<String, dynamic> json) => AdviserProfileData(
        id: json["id"],
        avatar: json["avatar"],
        description: json["description"],
        fullName: json["full_name"],
        info: json["info"],
        rate: json["rate"],
        adviceCount: json["advice_count"],
        experienceYear: json["experience_year"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        document: json["document"] == null
            ? []
            : List<Document>.from(
                json["document"]!.map((x) => Document.fromJson(x))),
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
      };
}

class Category {
  int? id;
  String? name;
  List<Category>? children;
  int? parentId;

  Category({
    this.id,
    this.name,
    this.children,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        children: json["children"] == null
            ? []
            : List<Category>.from(
                json["children"]!.map((x) => Category.fromJson(x))),
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "parent_id": parentId,
      };
}

class Document {
  int? id;
  String? file;

  Document({
    this.id,
    this.file,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"]??0,
        file: json["file"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
      };
}
