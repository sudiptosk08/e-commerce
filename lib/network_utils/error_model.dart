import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.message,
    required this.data,
  });

  final Message message;
  final List<dynamic> data;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: Message.fromJson(json["message"]),
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class Message {
  Message({
    required this.errors,
  });

  final String errors;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
      };
}
