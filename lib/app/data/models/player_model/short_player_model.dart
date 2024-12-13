import 'dart:convert';

class ShortPlayerModel {
  bool? success;
  String? message;
  Data? data;

  ShortPlayerModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShortPlayerModel.fromRawJson(String str) => ShortPlayerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShortPlayerModel.fromJson(Map<String, dynamic> json) => ShortPlayerModel(
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
  List<ShortPlayerList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<ShortPlayerList>.from(json["result"]!.map((x) => ShortPlayerList.fromJson(x))),
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

class ShortPlayerList {
  String? id;
  String? name;
  League? league;
  Team? team;
  String? position;
  String? playerImage;
  String? playerBgImage;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isBookmark;

  ShortPlayerList({
    this.id,
    this.name,
    this.league,
    this.team,
    this.position,
    this.playerImage,
    this.playerBgImage,
    this.totalTips,
    this.paidAmount,
    this.dueAmount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isBookmark,
  });

  factory ShortPlayerList.fromRawJson(String str) => ShortPlayerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShortPlayerList.fromJson(Map<String, dynamic> json) => ShortPlayerList(
    id: json["_id"],
    name: json["name"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    position: json["position"],
    playerImage: json["player_image"],
    playerBgImage: json["player_bg_image"],
    totalTips: json["totalTips"],
    paidAmount: json["paidAmount"],
    dueAmount: json["dueAmount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isBookmark: json["isBookmark"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "league": league?.toJson(),
    "team": team?.toJson(),
    "position": position,
    "player_image": playerImage,
    "player_bg_image": playerBgImage,
    "totalTips": totalTips,
    "paidAmount": paidAmount,
    "dueAmount": dueAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isBookmark": isBookmark,
  };
}

class League {
  String? id;
  String? name;
  String? sport;

  League({
    this.id,
    this.name,
    this.sport,
  });

  factory League.fromRawJson(String str) => League.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory League.fromJson(Map<String, dynamic> json) => League(
    id: json["_id"],
    name: json["name"],
    sport: json["sport"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "sport": sport,
  };
}

class Team {
  String? id;
  String? name;

  Team({
    this.id,
    this.name,
  });

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
