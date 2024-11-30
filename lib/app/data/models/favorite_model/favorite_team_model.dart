import 'dart:convert';

class FavoriteTeamModel {
  bool? success;
  String? message;
  List<FavoriteTeamList>? data;

  FavoriteTeamModel({
    this.success,
    this.message,
    this.data,
  });

  factory FavoriteTeamModel.fromRawJson(String str) => FavoriteTeamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteTeamModel.fromJson(Map<String, dynamic> json) => FavoriteTeamModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FavoriteTeamList>.from(json["data"]!.map((x) => FavoriteTeamList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FavoriteTeamList {
  String? id;
  Team? team;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  FavoriteTeamList({
    this.id,
    this.team,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FavoriteTeamList.fromRawJson(String str) => FavoriteTeamList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteTeamList.fromJson(Map<String, dynamic> json) => FavoriteTeamList(
    id: json["_id"],
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    user: json["user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "team": team?.toJson(),
    "user": user,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Team {
  String? id;
  String? name;
  String? teamLogo;
  League? league;
  String? teamBgImage;

  Team({
    this.id,
    this.name,
    this.teamLogo,
    this.league,
    this.teamBgImage,
  });

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["_id"],
    name: json["name"],
    teamLogo: json["team_logo"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    teamBgImage: json["team_bg_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "team_logo": teamLogo,
    "league": league?.toJson(),
    "team_bg_image": teamBgImage,
  };
}

class League {
  String? id;
  String? name;
  String? sport;

  League({
    this.id,
    this.name,
    this.sport
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
