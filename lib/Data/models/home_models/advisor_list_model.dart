
import 'dart:convert';

AdvisorListModel advisorListModelFromJson(dynamic str) =>
    AdvisorListModel.fromJson(str);

String advisorListModelToJson(AdvisorListModel data) =>
    json.encode(data.toJson());

class AdvisorListModel {
  List<AdviserData>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  AdvisorListModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory AdvisorListModel.fromJson(Map<String, dynamic> json) =>
      AdvisorListModel(
        data: json["data"] == null
            ? []
            : List<AdviserData>.from(
                json["data"]!.map((x) => AdviserData.fromJson(x))),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class AdviserData {
  dynamic id;
  String? avatar;
  String? fullName;
  String? info;
  String? description;
  List<Category>? category;
  String? rate;

  AdviserData({
    this.id,
    this.avatar,
    this.fullName,
    this.info,
    this.description,
    this.category,
    this.rate,
  });

  factory AdviserData.fromJson(Map<String, dynamic> json) => AdviserData(
        id: json["id"],
        avatar: json["avatar"],
        fullName: json["full_name"],
        info: json["info"],
        description: json["description"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "full_name": fullName,
        "info": info,
        "description": description,
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
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
