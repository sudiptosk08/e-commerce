// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  List<CategoryListData> data;
  bool status;

  CategoryListModel({
    required this.data,
    required this.status,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        data: List<CategoryListData>.from(json["data"].map((x) => CategoryListData.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class CategoryListData {
  int id;
  String name;
  String slug;
  String icon;
  String image;
  List<CategoryListData>? subcategories;

  CategoryListData({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.image,
    this.subcategories,
  });

  factory CategoryListData.fromJson(Map<String, dynamic> json) => CategoryListData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        image: json["image"],
        subcategories: json["subcategories"] == null
            ? []
            : List<CategoryListData>.from(
                json["subcategories"]!.map((x) => CategoryListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "image": image,
        "subcategories": subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
      };
}
