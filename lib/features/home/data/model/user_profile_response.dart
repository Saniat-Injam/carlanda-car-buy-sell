import 'dart:convert';

// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  bool? success;
  int? statusCode;
  String? message;
  UserData? data;

  UserProfileResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserData {
  String? id;
  String? fullName;
  String? profileImage;
  String? email;
  String? address;
  String? phone;
  DateTime? createdAt;

  UserData({
    this.id,
    this.fullName,
    this.profileImage,
    this.email,
    this.address,
    this.phone,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    fullName: json["fullName"],
    profileImage: json["profileImage"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profileImage": profileImage,
    "email": email,
    "address": address,
    "phone": phone,
    "createdAt": createdAt?.toIso8601String(),
  };
}
