import 'dart:convert';

class LeagueModel {
  bool? success;
  String? message;
  Data? data;

  LeagueModel({
    this.success,
    this.message,
    this.data,
  });

  factory LeagueModel.fromRawJson(String str) => LeagueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
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
  List<LeagueList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<LeagueList>.from(json["result"]!.map((x) => LeagueList.fromJson(x))),
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

class LeagueList {
  String? id;
  String? name;
  String? leagueImage;
  String? sport;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LeagueList({
    this.id,
    this.name,
    this.leagueImage,
    this.sport,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LeagueList.fromRawJson(String str) => LeagueList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeagueList.fromJson(Map<String, dynamic> json) => LeagueList(
    id: json["_id"],
    name: json["name"],
    leagueImage: json["league_image"],
    sport: json["sport"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "league_image": leagueImage,
    "sport": sport,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
