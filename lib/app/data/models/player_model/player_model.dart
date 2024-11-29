import 'dart:convert';

class PlayerModel {
  bool? success;
  String? message;
  Data? data;

  PlayerModel({
    this.success,
    this.message,
    this.data,
  });

  factory PlayerModel.fromRawJson(String str) => PlayerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
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
  List<PlayerList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<PlayerList>.from(json["result"]!.map((x) => PlayerList.fromJson(x))),
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

class PlayerList {
  String? id;
  String? name;
  League? league;
  Team? team;
  String? position;
  String? playerImage;
  PlayerBgImage? playerBgImage;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isBookmark;

  PlayerList({
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

  factory PlayerList.fromRawJson(String str) => PlayerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerList.fromJson(Map<String, dynamic> json) => PlayerList(
    id: json["_id"],
    name: json["name"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    position: json["position"],
    playerImage:json["player_image"],
    playerBgImage: playerBgImageValues.map[json["player_bg_image"]]!,
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
    "player_image": playerImageValues.reverse[playerImage],
    "player_bg_image": playerBgImageValues.reverse[playerBgImage],
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

enum PlayerBgImage {
  EMPTY,
  UPLOADS_IMAGES_PLAYER_BG_IMAGE_1731321560795_IMAGE_PNG
}

final playerBgImageValues = EnumValues({
  "": PlayerBgImage.EMPTY,
  "uploads\\images\\player_bg_image\\1731321560795-image.png": PlayerBgImage.UPLOADS_IMAGES_PLAYER_BG_IMAGE_1731321560795_IMAGE_PNG
});

enum PlayerImage {
  EMPTY,
  UPLOADS_IMAGES_PLAYER_IMAGE_1731321560794_IMAGE_11_PNG
}

final playerImageValues = EnumValues({
  "": PlayerImage.EMPTY,
  "uploads\\images\\player_image\\1731321560794-image 11.png": PlayerImage.UPLOADS_IMAGES_PLAYER_IMAGE_1731321560794_IMAGE_11_PNG
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
