import 'dart:convert';

class TeamModel {
  bool? success;
  String? message;
  Data? data;

  TeamModel({
    this.success,
    this.message,
    this.data,
  });

  factory TeamModel.fromRawJson(String str) => TeamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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
  List<TeamList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<TeamList>.from(json["result"]!.map((x) => TeamList.fromJson(x))),
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

class TeamList {
  String? id;
  String? name;
  String? teamLogo;
  League? league;
  String? teamBgImage;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isBookmark;
  String? user;

  TeamList({
    this.id,
    this.name,
    this.teamLogo,
    this.league,
    this.teamBgImage,
    this.totalTips,
    this.paidAmount,
    this.dueAmount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isBookmark,
    this.user,
  });

  factory TeamList.fromRawJson(String str) => TeamList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
    id: json["_id"],
    name: json["name"],
    teamLogo: json["team_logo"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    teamBgImage: json["team_bg_image"],
    totalTips: json["totalTips"],
    paidAmount: json["paidAmount"],
    dueAmount: json["dueAmount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isBookmark: json["isBookmark"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "team_logo": teamLogo,
    "league": league?.toJson(),
    "team_bg_image": teamBgImage,
    "totalTips": totalTips,
    "paidAmount": paidAmount,
    "dueAmount": dueAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isBookmark": isBookmark,
    "user": user,
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
