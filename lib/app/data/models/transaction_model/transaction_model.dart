import 'dart:convert';

class TransactionModel {
  bool? success;
  String? message;
  Data? data;

  TransactionModel({
    this.success,
    this.message,
    this.data,
  });

  factory TransactionModel.fromRawJson(String str) => TransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
  List<TransactionList>? result;

  Data({
    this.meta,
    this.result,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<TransactionList>.from(json["result"]!.map((x) => TransactionList.fromJson(x))),
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

class TransactionList {
  String? id;
  int? amount;
  String? transactionType;
  String? paymentBy;
  String? status;
  String? description;
  String? entityId;
  String? entityType;
  String? transactionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TransactionList({
    this.id,
    this.amount,
    this.transactionType,
    this.paymentBy,
    this.status,
    this.description,
    this.entityId,
    this.entityType,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TransactionList.fromRawJson(String str) => TransactionList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionList.fromJson(Map<String, dynamic> json) => TransactionList(
    id: json["_id"],
    amount: json["amount"],
    transactionType: json["transactionType"],
    paymentBy: json["paymentBy"],
    status: json["status"],
    description: json["description"],
    entityId: json["entityId"],
    entityType: json["entityType"],
    transactionId: json["transactionId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "transactionType": transactionType,
    "paymentBy": paymentBy,
    "status": status,
    "description": description,
    "entityId": entityId,
    "entityType": entityType,
    "transactionId": transactionId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
