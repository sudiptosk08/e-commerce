import 'dart:convert';

MyOrderListModel myOrderListModelFromJson(String str) =>
    MyOrderListModel.fromJson(json.decode(str));

String myOrderListModelToJson(MyOrderListModel data) =>
    json.encode(data.toJson());

class MyOrderListModel {
  List<Datum> data;
  Links links;
  Meta meta;
  bool status;

  MyOrderListModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
  });

  factory MyOrderListModel.fromJson(Map<String, dynamic> json) =>
      MyOrderListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  String orderId;
  String totalPrice;
  String deliveryCharge;
  int subTotal;
  String status;
  BillingAddress billingAddress;
  Address userAddress;
  UserDetails userDetails;
  List<Item> items;
  String paymentStatus;
  String paymentMethod;
  dynamic deliveryMethodId;
  String createdAt;

  Datum({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.deliveryCharge,
    required this.subTotal,
    required this.status,
    required this.billingAddress,
    required this.userAddress,
    required this.userDetails,
    required this.items,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryMethodId,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderId: json["order_id"],
        totalPrice: json["total_price"],
        deliveryCharge: json["delivery_charge"],
        subTotal: json["sub_total"],
        status: json["status"],
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        userAddress: Address.fromJson(json["user_address"]),
        userDetails: UserDetails.fromJson(json["user_details"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        deliveryMethodId: json["delivery_method_id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "total_price": totalPrice,
        "delivery_charge": deliveryCharge,
        "sub_total": subTotal,
        "status": status,
        "billing_address": billingAddress.toJson(),
        "user_address": userAddress.toJson(),
        "user_details": userDetails.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "delivery_method_id": deliveryMethodId,
        "created_at": createdAt,
      };
}

class BillingAddress {
  String firstName;
  String lastName;
  String phone;
  String email;
  dynamic region;
  dynamic address;
  dynamic area;

  BillingAddress({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.region,
    required this.address,
    required this.area,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        region: json["region"],
        address: json["address"],
        area: json["area"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "region": region,
        "address": address,
        "area": area,
      };
}

class Item {
  dynamic id;
  String name;
  dynamic quantity;
  dynamic price;
  dynamic discount;
  dynamic discountPrice;
  dynamic additionalPrice;
  dynamic total;
  String image;
  List<Variant> variant;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.additionalPrice,
    required this.total,
    required this.image,
    required this.variant,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        additionalPrice: json["additional_price"],
        total: json["total"],
        image: json["image"],
        variant: List<Variant>.from(
          (json["variant"] ?? []).map((x) => Variant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "price": price,
        "discount": discount,
        "discount_price": discountPrice,
        "additional_price": additionalPrice,
        "total": total,
        "image": image,
        "variant": List<dynamic>.from(variant.map((x) => x.toJson())),
      };
}

class Variant {
  int id;
  String name;
  String value;
  String additionalPrice;

  Variant({
    required this.id,
    required this.name,
    required this.value,
    required this.additionalPrice,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        name: json["name"],
        value: json["value"],
        additionalPrice: json["additional_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "additional_price": additionalPrice,
      };
}

class Address {
  int id;
  String region;
  String address;
  String area;
  String phone;
  String city;
  String addressType;

  Address({
    required this.id,
    required this.region,
    required this.address,
    required this.area,
    required this.phone,
    required this.city,
    required this.addressType,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        region: json["region"],
        address: json["address"],
        area: json["area"],
        phone: json["phone"],
        city: json["city"],
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region": region,
        "address": address,
        "area": area,
        "phone": phone,
        "city": city,
        "address_type": addressType,
      };
}

class UserDetails {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  dynamic email;
  String role;
  List<Address> address;

  UserDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.email,
    required this.role,
    required this.address,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        role: json["role"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "phone": phone,
        "email": email,
        "role": role,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
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
