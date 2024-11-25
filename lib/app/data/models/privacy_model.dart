import 'dart:convert';

class PrivacyModel {
  bool? success;
  String? message;
  PrivacyData? data;

  PrivacyModel({
    this.success,
    this.message,
    this.data,
  });

  factory PrivacyModel.fromRawJson(String str) => PrivacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PrivacyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PrivacyData {
  String? id;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? dataId;

  PrivacyData({
    this.id,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dataId,
  });

  factory PrivacyData.fromRawJson(String str) => PrivacyData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyData.fromJson(Map<String, dynamic> json) => PrivacyData(
    id: json["_id"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    dataId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "id": dataId,
  };
}
