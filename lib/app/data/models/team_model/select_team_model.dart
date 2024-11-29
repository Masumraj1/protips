import 'dart:convert';

class SelectTeamModel {
  bool? success;
  String? message;
  Data? data;

  SelectTeamModel({
    this.success,
    this.message,
    this.data,
  });

  factory SelectTeamModel.fromRawJson(String str) => SelectTeamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectTeamModel.fromJson(Map<String, dynamic> json) => SelectTeamModel(
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
  List<SelectTeamList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<SelectTeamList>.from(json["result"]!.map((x) => SelectTeamList.fromJson(x))),
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

class SelectTeamList {
  String? id;
  String? name;
  String? teamLogo;
  League? league;
  String? teamBgImage;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  int? v;
  DateTime? updatedAt;
  String? user;
  bool? isBookmark;

  SelectTeamList({
    this.id,
    this.name,
    this.teamLogo,
    this.league,
    this.teamBgImage,
    this.totalTips,
    this.paidAmount,
    this.dueAmount,
    this.v,
    this.updatedAt,
    this.user,
    this.isBookmark,
  });

  factory SelectTeamList.fromRawJson(String str) => SelectTeamList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectTeamList.fromJson(Map<String, dynamic> json) => SelectTeamList(
    id: json["_id"],
    name: json["name"],
    teamLogo: json["team_logo"],
    league: json["league"] == null ? null : League.fromJson(json["league"]),
    teamBgImage: json["team_bg_image"],
    totalTips: json["totalTips"],
    paidAmount: json["paidAmount"],
    dueAmount: json["dueAmount"],
    v: json["__v"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"],
    isBookmark: json["isBookmark"],
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
    "__v": v,
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user,
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
