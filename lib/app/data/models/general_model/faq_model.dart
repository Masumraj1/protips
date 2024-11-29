import 'dart:convert';

class FaqModel {
  bool? success;
  String? message;
  List<FaqList>? data;

  FaqModel({
    this.success,
    this.message,
    this.data,
  });

  factory FaqModel.fromRawJson(String str) => FaqModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FaqList>.from(json["data"]!.map((x) => FaqList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FaqList {
  String? id;
  String? question;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? datumId;

  FaqList({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  factory FaqList.fromRawJson(String str) => FaqList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "id": datumId,
  };
}
