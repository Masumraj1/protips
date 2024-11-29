import 'dart:convert';

class FavoritePlayerModel {
  bool? success;
  String? message;
  List<FavoritePlayerList>? data;

  FavoritePlayerModel({
    this.success,
    this.message,
    this.data,
  });

  factory FavoritePlayerModel.fromRawJson(String str) => FavoritePlayerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoritePlayerModel.fromJson(Map<String, dynamic> json) => FavoritePlayerModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FavoritePlayerList>.from(json["data"]!.map((x) => FavoritePlayerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FavoritePlayerList {
  String? id;
  Player? player;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  FavoritePlayerList({
    this.id,
    this.player,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FavoritePlayerList.fromRawJson(String str) => FavoritePlayerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoritePlayerList.fromJson(Map<String, dynamic> json) => FavoritePlayerList(
    id: json["_id"],
    player: json["player"] == null ? null : Player.fromJson(json["player"]),
    user: json["user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "player": player?.toJson(),
    "user": user,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Player {
  String? id;
  String? name;
  League? league;
  League? team;
  String? position;
  String? playerImage;
  String? playerBgImage;

  Player({
    this.id,
    this.name,
    this.league,
    this.team,
    this.position,
    this.playerImage,
    this.playerBgImage,
  });

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["_id"],
    name: json["name"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    team: json["team"] == null ? null : League.fromJson(json["team"]),
    position: json["position"],
    playerImage: json["player_image"],
    playerBgImage: json["player_bg_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "league": league?.toJson(),
    "team": team?.toJson(),
    "position": position,
    "player_image": playerImage,
    "player_bg_image": playerBgImage,
  };
}

class League {
  String? id;
  String? name;

  League({
    this.id,
    this.name,
  });

  factory League.fromRawJson(String str) => League.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory League.fromJson(Map<String, dynamic> json) => League(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
