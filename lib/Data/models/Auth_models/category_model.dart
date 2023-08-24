// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(dynamic str) => CategoryModel.fromJson(str);

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<CategoryData>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  CategoryModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
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

class CategoryData {
  int? id;
  String? name;
  List<CategoryData>? children;
  int? parentId;
  bool? selected;

  CategoryData({
    this.id,
    this.name,
    this.children,
    this.parentId,
    this.selected,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
    children: json["children"] == null ? [] : List<CategoryData>.from(json["children"]!.map((x) => CategoryData.fromJson(x))),
    parentId: json["parent_id"],
    selected: json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "parent_id": parentId,
    "selected": selected,
  };
}
