
import 'dart:convert';

ListRejectionModel listRejectionModelFromJson(dynamic str) =>
    ListRejectionModel.fromJson(str);

String listRejectionModelToJson(ListRejectionModel data) =>
    json.encode(data.toJson());

class ListRejectionModel {
  List<RejectData>? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  ListRejectionModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory ListRejectionModel.fromJson(Map<String, dynamic> json) =>
      ListRejectionModel(
        data: json["data"] == null
            ? []
            : List<RejectData>.from(
                json["data"]!.map((x) => RejectData.fromJson(x))),
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

class RejectData {
  dynamic id;
  String? name;

  RejectData({
    this.id,
    this.name,
  });

  factory RejectData.fromJson(Map<String, dynamic> json) => RejectData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
