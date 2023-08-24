// To parse this JSON data, do
//
//     final advisorListModel = advisorListModelFromJson(jsonString);

import 'dart:convert';

AdvisorListModel advisorListModelFromJson(dynamic str) => AdvisorListModel.fromJson(str);

String advisorListModelToJson(AdvisorListModel data) => json.encode(data.toJson());

class AdvisorListModel {
  List<Datum>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  AdvisorListModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory AdvisorListModel.fromJson(Map<String, dynamic> json) => AdvisorListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

class Datum {
  int? id;
  String? avatar;
  String? fullName;
  String? info;
  String? description;
  List<Category>? category;

  Datum({
    this.id,
    this.avatar,
    this.fullName,
    this.info,
    this.description,
    this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    avatar: json["avatar"],
    fullName: json["full_name"],
    info: json["info"],
    description: json["description"],
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "full_name": fullName,
    "info": info,
    "description": description,
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
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
    children: json["children"] == null ? [] : List<Category>.from(json["children"]!.map((x) => Category.fromJson(x))),
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "parent_id": parentId,
  };
}
