import 'dart:convert';

class SelectedRewardModel {
  bool? success;
  String? message;
  Data? data;

  SelectedRewardModel({
    this.success,
    this.message,
    this.data,
  });

  factory SelectedRewardModel.fromRawJson(String str) => SelectedRewardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectedRewardModel.fromJson(Map<String, dynamic> json) => SelectedRewardModel(
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
  List<SelectRewardList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<SelectRewardList>.from(json["result"]!.map((x) => SelectRewardList.fromJson(x))),
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

class SelectRewardList {
  String? id;
  Category? category;
  String? name;
  String? rewardImage;
  int? pointRequired;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SelectRewardList({
    this.id,
    this.category,
    this.name,
    this.rewardImage,
    this.pointRequired,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SelectRewardList.fromRawJson(String str) => SelectRewardList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectRewardList.fromJson(Map<String, dynamic> json) => SelectRewardList(
    id: json["_id"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    name: json["name"],
    rewardImage: json["reward_image"],
    pointRequired: json["pointRequired"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category?.toJson(),
    "name": name,
    "reward_image": rewardImage,
    "pointRequired": pointRequired,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Category {
  String? id;
  String? name;
  String? deliveryOption;

  Category({
    this.id,
    this.name,
    this.deliveryOption,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    deliveryOption: json["deliveryOption"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "deliveryOption": deliveryOption,
  };
}
