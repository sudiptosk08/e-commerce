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
  ProductDetailsData data;

  ProductDetailsModel({
    required this.status,
    required this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        status: json["status"],
        data: ProductDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class ProductDetailsData {
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
  List<Review> reviews;
  bool wishlist;

  ProductDetailsData({
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
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => ProductDetailsData(
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
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        wishlist: json["wishlist"],
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
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "wishlist": wishlist,
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

class Review {
  int id;
  String review;
  String rating;
  String userName;
  String createTime;
  String updateTime;
  String email;
  List<String> images;

  Review({
    required this.id,
    required this.review,
    required this.rating,
    required this.userName,
    required this.createTime,
    required this.updateTime,
    required this.email,
    required this.images,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        review: json["review"],
        rating: json["rating"],
        userName: json["user_name"],
        createTime: json["create_time"],
        updateTime: json["update_time"],
        email: json["email"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "rating": rating,
        "user_name": userName,
        "create_time": createTime,
        "update_time": updateTime,
        "email": email,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
