import 'dart:convert';

class ProfileModel {
  bool? success;
  String? message;
  ProfileData? data;

  ProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileData {
  String? id;
  String? user;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? address;
  String? profileImage;
  int? totalAmount;
  int? totalPoint;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileData({
    this.id,
    this.user,
    this.name,
    this.username,
    this.phone,
    this.email,
    this.address,
    this.profileImage,
    this.totalAmount,
    this.totalPoint,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileData.fromRawJson(String str) => ProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["_id"],
    user: json["user"],
    name: json["name"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    profileImage: json["profile_image"],
    totalAmount: json["totalAmount"],
    totalPoint: json["totalPoint"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "name": name,
    "username": username,
    "phone": phone,
    "email": email,
    "address": address,
    "profile_image": profileImage,
    "totalAmount": totalAmount,
    "totalPoint": totalPoint,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
