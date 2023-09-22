// To parse this JSON data, do
//
//     final shippingAddressList = shippingAddressListFromJson(jsonString);

import 'dart:convert';

ShippingAddressList shippingAddressListFromJson(String str) =>
    ShippingAddressList.fromJson(json.decode(str));

String shippingAddressListToJson(ShippingAddressList data) =>
    json.encode(data.toJson());

class ShippingAddressList {
  bool status;
  List<Datum> data;

  ShippingAddressList({
    required this.status,
    required this.data,
  });

  factory ShippingAddressList.fromJson(Map<String, dynamic> json) =>
      ShippingAddressList(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String region;
  String address;
  String area;
  String phone;
  String city;
  String addressType;

  Datum({
    required this.id,
    required this.region,
    required this.address,
    required this.area,
    required this.phone,
    required this.city,
    required this.addressType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
