

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  final List<CategroyListData> data;
  final bool status;

  CategoryListModel({
    required this.data,
    required this.status,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        data: List<CategroyListData>.from(json["data"].map((x) => CategroyListData.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class CategroyListData {
  final int id;
  final String? name;
  final String? slug;
  final String? icon;
  final String? image;
  final List<CategroyListData>? subcategories;

  CategroyListData({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.image,
    this.subcategories,
  });

  factory CategroyListData.fromJson(Map<String, dynamic> json) => CategroyListData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        image: json["image"],
        subcategories: json["subcategories"] == null
            ? []
            : List<CategroyListData>.from(
                json["subcategories"]!.map((x) => CategroyListData.fromJson(x))),
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
