// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  bool status;
  Data data;

  ProductDetailsModel({
    required this.status,
    required this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String name;
  String slug;
  Category category;
  Category subcategory;
  String description;
  String price;
  String brand;
  String discount;
  int discountPrice;
  int saved;
  int stock;
  String rating;
  String thumbnail;
  List<String> gallery;
  List<dynamic> reviews;
  bool wishlist;
  Variants variants;

  Data({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.price,
    required this.brand,
    required this.discount,
    required this.discountPrice,
    required this.saved,
    required this.stock,
    required this.rating,
    required this.thumbnail,
    required this.gallery,
    required this.reviews,
    required this.wishlist,
    required this.variants,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        category: Category.fromJson(json["category"]),
        subcategory: Category.fromJson(json["subcategory"]),
        description: json["description"],
        price: json["price"],
        brand: json["brand"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        saved: json["saved"],
        stock: json["stock"],
        rating: json["rating"],
        thumbnail: json["thumbnail"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        wishlist: json["wishlist"],
        variants: Variants.fromJson(json["variants"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "category": category.toJson(),
        "subcategory": subcategory.toJson(),
        "description": description,
        "price": price,
        "brand": brand,
        "discount": discount,
        "discount_price": discountPrice,
        "saved": saved,
        "stock": stock,
        "rating": rating,
        "thumbnail": thumbnail,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "wishlist": wishlist,
        "variants": variants.toJson(),
      };
}

class Category {
  int id;
  String name;
  String slug;
  String icon;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "image": image,
      };
}

class Variants {
  List<Color> size;
  List<Color> color;

  Variants({
    required this.size,
    required this.color,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        size: List<Color>.from(json["size"].map((x) => Color.fromJson(x))),
        color: List<Color>.from(json["color"].map((x) => Color.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "color": List<dynamic>.from(color.map((x) => x.toJson())),
      };
}

class Color {
  int id;
  String value;
  int additionalPrice;

  Color({
    required this.id,
    required this.value,
    required this.additionalPrice,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json["id"],
        value: json["value"],
        additionalPrice: json["additional_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "additional_price": additionalPrice,
      };
}
