// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

class PostResponse {
  bool error;
  String errorCode;
  String id;
  String message;

  PostResponse({
    this.error,
    this.errorCode,
    this.id,
    this.message,
  });

  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostResponse.fromJson(Map<String, dynamic> json) => new PostResponse(
        error: json["error"],
        errorCode: json["error_code"],
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_code": errorCode,
        "id": id,
        "message": message,
      };
}
