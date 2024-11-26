import 'dart:convert';

class RewadzModel {
  bool? success;
  String? message;
  Data? data;

  RewadzModel({
    this.success,
    this.message,
    this.data,
  });

  factory RewadzModel.fromRawJson(String str) => RewadzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RewadzModel.fromJson(Map<String, dynamic> json) => RewadzModel(
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
  List<RewardList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<RewardList>.from(json["result"]!.map((x) => RewardList.fromJson(x))),
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

class RewardList {
  String? id;
  String? name;
  String? image;
  String? deliveryOption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RewardList({
    this.id,
    this.name,
    this.image,
    this.deliveryOption,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RewardList.fromRawJson(String str) => RewardList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RewardList.fromJson(Map<String, dynamic> json) => RewardList(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    deliveryOption: json["deliveryOption"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "deliveryOption": deliveryOption,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
