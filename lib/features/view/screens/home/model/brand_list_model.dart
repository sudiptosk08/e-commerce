// To parse this JSON data, do
//
//     final brandListModel = brandListModelFromJson(jsonString);

import 'dart:convert';

BrandListModel brandListModelFromJson(String str) =>
    BrandListModel.fromJson(json.decode(str));

String brandListModelToJson(BrandListModel data) => json.encode(data.toJson());

class BrandListModel {
  bool status;
  String message;
  List<BrandListData> data;

  BrandListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BrandListModel.fromJson(Map<String, dynamic> json) => BrandListModel(
        status: json["status"],
        message: json["message"],
        data: List<BrandListData>.from(json["data"].map((x) => BrandListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BrandListData {
  int id;
  String name;
  String slug;
  String description;
  String image;

  BrandListData({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
  });

  factory BrandListData.fromJson(Map<String, dynamic> json) => BrandListData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
      };
}
