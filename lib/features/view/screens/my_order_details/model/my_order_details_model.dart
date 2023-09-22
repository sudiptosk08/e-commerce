// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

MyOrderDetailsModel orderDetailsModelFromJson(String str) =>
    MyOrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(MyOrderDetailsModel data) =>
    json.encode(data.toJson());

class MyOrderDetailsModel {
  bool status;
  OrderDetailsData data;

  MyOrderDetailsModel({
    required this.status,
    required this.data,
  });

  factory MyOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      MyOrderDetailsModel(
        status: json["status"],
        data: OrderDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class OrderDetailsData {
  int id;
  String orderId;
  String totalPrice;
  String discount;
  String payable;
  String paid;
  String due;
  String status;
  dynamic firstName;
  dynamic lastName;
  String phone;
  dynamic email;
  String region;
  String address;
  String area;
  String city;
  String addressType;
  UserDetails userDetails;
  List<Item> items;
  String paymentStatus;
  String paymentMethod;
  String deliveryMethodId;

  OrderDetailsData({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.discount,
    required this.payable,
    required this.paid,
    required this.due,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.region,
    required this.address,
    required this.area,
    required this.city,
    required this.addressType,
    required this.userDetails,
    required this.items,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryMethodId,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
        id: json["id"],
        orderId: json["order_id"],
        totalPrice: json["total_price"],
        discount: json["discount"],
        payable: json["payable"],
        paid: json["paid"],
        due: json["due"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        region: json["region"],
        address: json["address"],
        area: json["area"],
        city: json["city"],
        addressType: json["address_type"],
        userDetails: UserDetails.fromJson(json["user_details"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        deliveryMethodId: json["delivery_method_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "total_price": totalPrice,
        "discount": discount,
        "payable": payable,
        "paid": paid,
        "due": due,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "region": region,
        "address": address,
        "area": area,
        "city": city,
        "address_type": addressType,
        "user_details": userDetails.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "delivery_method_id": deliveryMethodId,
      };
}

class Item {
  int id;
  String quantity;
  String price;
  String discount;
  int discountPrice;
  String additionalPrice;
  int total;

  Item({
    required this.id,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.additionalPrice,
    required this.total,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        additionalPrice: json["additional_price"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "discount": discount,
        "discount_price": discountPrice,
        "additional_price": additionalPrice,
        "total": total,
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
