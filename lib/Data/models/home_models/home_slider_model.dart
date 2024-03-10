// To parse this JSON data, do
//
//     final homeSlider = homeSliderFromJson(jsonString);

import 'dart:convert';

HomeSlider homeSliderFromJson(dynamic str) => HomeSlider.fromJson(str);

String homeSliderToJson(HomeSlider data) => json.encode(data.toJson());

class HomeSlider {
  List<HSListData>? data;
  int? status;
  String? message;
  List<dynamic>? pagination;

  HomeSlider({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory HomeSlider.fromJson(Map<String, dynamic> json) => HomeSlider(
        data: json["data"] == null
            ? []
            : List<HSListData>.from(
                json["data"]!.map((x) => HSListData.fromJson(x))),
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

class HSListData {
  int? id;
  String? url;
  String? image;

  HSListData({
    this.id,
    this.url,
    this.image,
  });

  factory HSListData.fromJson(Map<String, dynamic> json) => HSListData(
        id: json["id"],
        url: json["url"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "image": image,
      };
}
