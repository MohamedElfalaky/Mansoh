// // To parse this JSON data, do
// //
// //     final countryModel = countryModelFromJson(jsonString);
//
// import 'dart:convert';
//
// CountryModel countryModelFromJson(dynamic str) => CountryModel.fromJson(str);
//
// String countryModelToJson(CountryModel data) => json.encode(data.toJson());
//
// class CountryModel {
//   List<CountryData>? data;
//   int? status;
//   String? message;
//   Pagination? pagination;
//
//   CountryModel({
//     this.data,
//     this.status,
//     this.message,
//     this.pagination,
//   });
//
//   factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
//         data: json["data"] == null
//             ? []
//             : List<CountryData>.from(
//                 json["data"]!.map((x) => CountryData.fromJson(x))),
//         status: json["status"],
//         message: json["message"] ?? "",
//         pagination: json["pagination"] == null
//             ? null
//             : Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "status": status,
//         "message": message,
//         "pagination": pagination?.toJson(),
//       };
// }
//
// class CountryData {
//   int? id;
//   String? name;
//
//   CountryData({
//     this.id,
//     this.name,
//   });
//
//   factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
//         id: json["id"] ?? 0,
//         name: json["name"] ?? "",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
//
// class Pagination {
//   int? total;
//   int? perPage;
//   int? currentPage;
//   int? totalPages;
//
//   Pagination({
//     this.total,
//     this.perPage,
//     this.currentPage,
//     this.totalPages,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         perPage: json["perPage"],
//         currentPage: json["currentPage"],
//         totalPages: json["total_pages"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "perPage": perPage,
//         "currentPage": currentPage,
//         "total_pages": totalPages,
//       };
// }

// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(dynamic str) => CountryModel.fromJson(str);

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  final List<CountryData>? data;
  final int? status;
  final String? message;
  final List<dynamic>? pagination;

  CountryModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    data: json["data"] == null ? [] : List<CountryData>.from(json["data"]!.map((x) => CountryData.fromJson(x))),
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

class CountryData {
  final int? id;
  final String? name;

  CountryData({
    this.id,
    this.name,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
