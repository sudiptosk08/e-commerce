// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  List<Datum> data;
  Links links;
  Meta meta;
  bool status;
  String message;

  WishListModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "status": status,
        "message": message,
      };
}

class Datum {
  int id;
  Product product;

  Datum({
    required this.id,
    required this.product,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
      };
}

class Product {
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
  bool wishlist;

  Product({
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
    required this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage:
            json["current_page"] ?? 0, // Provide a default value if null
        from: json["from"] ?? 0, // Provide a default value if null
        lastPage: json["last_page"] ?? 0, // Provide a default value if null
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"] ?? "", // Provide a default value if null
        perPage: json["per_page"] ?? 0, // Provide a default value if null
        to: json["to"] ?? 0, // Provide a default value if null
        total: json["total"] ?? 0, // Provide a default value if null
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
