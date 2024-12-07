import 'dart:convert';

class NotificationModel {
  bool? success;
  String? message;
  Data? data;

  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  List<NotificationList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<NotificationList>.from(json["result"]!.map((x) => NotificationList.fromJson(x))),
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

class NotificationList {
  String? id;
  Title? title;
  String? message;
  bool? seen;
  Receiver? receiver;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NotificationList({
    this.id,
    this.title,
    this.message,
    this.seen,
    this.receiver,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationList.fromRawJson(String str) => NotificationList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["_id"],
    title: titleValues.map[json["title"]]!,
    message: json["message"],
    seen: json["seen"],
    receiver: receiverValues.map[json["receiver"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": titleValues.reverse[title],
    "message": message,
    "seen": seen,
    "receiver": receiverValues.reverse[receiver],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Receiver {
  THE_67418_F4_CAF6_F94_D1_C2_EF4_A7_D
}

final receiverValues = EnumValues({
  "67418f4caf6f94d1c2ef4a7d": Receiver.THE_67418_F4_CAF6_F94_D1_C2_EF4_A7_D
});

enum Title {
  REDEEM_REQUEST_SENT_SUCCESSFULLY
}

final titleValues = EnumValues({
  "Redeem request sent successfully": Title.REDEEM_REQUEST_SENT_SUCCESSFULLY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
