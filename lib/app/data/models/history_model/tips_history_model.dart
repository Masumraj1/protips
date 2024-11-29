import 'dart:convert';

class TipsHistoryModel {
  bool? success;
  String? message;
  Data? data;

  TipsHistoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory TipsHistoryModel.fromRawJson(String str) => TipsHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TipsHistoryModel.fromJson(Map<String, dynamic> json) => TipsHistoryModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Meta? meta;
  List<TipsHistoryList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<TipsHistoryList>.from(json["result"]!.map((x) => TipsHistoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class TipsHistoryList {
  String? id;
  User? user;
  String? entityId;
  String? entityType;
  int? point;
  int? amount;
  String? paymentStatus;
  String? tipBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Entity? entity;

  TipsHistoryList({
    this.id,
    this.user,
    this.entityId,
    this.entityType,
    this.point,
    this.amount,
    this.paymentStatus,
    this.tipBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.entity,
  });

  factory TipsHistoryList.fromRawJson(String str) => TipsHistoryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TipsHistoryList.fromJson(Map<String, dynamic> json) => TipsHistoryList(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    entityId: json["entityId"],
    entityType: json["entityType"],
    point: json["point"],
    amount: json["amount"],
    paymentStatus: json["paymentStatus"],
    tipBy: json["tipBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "entityId": entityId,
    "entityType": entityType,
    "point": point,
    "amount": amount,
    "paymentStatus": paymentStatus,
    "tipBy": tipBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "entity": entity?.toJson(),
  };
}

class Entity {
  String? name;
  String? position;
  String? playerImage;

  Entity({
    this.name,
    this.position,
    this.playerImage,
  });

  factory Entity.fromRawJson(String str) => Entity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    name: json["name"],
    position: json["position"],
    playerImage: json["player_image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "position": position,
    "player_image": playerImage,
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? profileImage;

  User({
    this.id,
    this.name,
    this.email,
    this.profileImage,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "profile_image": profileImage,
  };
}
