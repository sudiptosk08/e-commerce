// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  List<ProductListData> data;
  Links links;
  Meta meta;
  bool status;

  ProductListModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        data: List<ProductListData>.from(json["data"].map((x) => ProductListData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "status": status,
      };
}

class ProductListData {
  int id;
    String name;
    String slug;
    Category category;
    Category subcategory;
    String description;
    String price;
    dynamic brand;
    String discount;
    int discountPrice;
    int saved;
    int stock;
    String rating;
    String thumbnail;
    List<String> gallery;
    bool wishlist;


  ProductListData({
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

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
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
        image: json["image"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "icon" : icon,
      };
}

class Links {
  dynamic first;
  dynamic last;
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
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  List<Link> links;
  String path;
  dynamic perPage;
  dynamic to;
  dynamic total;

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
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
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
