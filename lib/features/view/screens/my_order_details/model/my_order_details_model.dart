// To parse this JSON data, do
//
//     final myOrderDetailsModel = myOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

MyOrderDetailsModel myOrderDetailsModelFromJson(String str) =>
    MyOrderDetailsModel.fromJson(json.decode(str));

String myOrderDetailsModelToJson(MyOrderDetailsModel data) =>
    json.encode(data.toJson());

class MyOrderDetailsModel {
  bool status;
  Data data;

  MyOrderDetailsModel({
    required this.status,
    required this.data,
  });

  factory MyOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      MyOrderDetailsModel(
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
  dynamic productId;
  String name;
  dynamic quantity;
  dynamic price;
  dynamic discount;
  dynamic discountPrice;
  dynamic additionalPrice;
  dynamic total;
  String image;
  List<Variant> variants;

  Item({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.additionalPrice,
    required this.total,
    required this.image,
    required this.variants,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        additionalPrice: json["additional_price"],
        total: json["total"],
        image: json["image"],
        variants: json["variants"] != null
            ? List<Variant>.from(
                json["variants"].map((x) => Variant.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "quantity": quantity,
        "price": price,
        "discount": discount,
        "discount_price": discountPrice,
        "additional_price": additionalPrice,
        "total": total,
        "image": image,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
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
