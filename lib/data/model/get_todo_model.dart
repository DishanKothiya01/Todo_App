// To parse this JSON data, do
//
//     final getTodoModel = getTodoModelFromJson(jsonString);

import 'dart:convert';

List<GetTodoModel> getTodoModelFromJson(String str) => List<GetTodoModel>.from(json.decode(str).map((x) => GetTodoModel.fromJson(x)));

String getTodoModelToJson(List<GetTodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTodoModel {
  final String? name;
  final String? email;
  final num? phoneNumber;
  final String? id;
  final String? title;
  final String? description;
  final bool? isCompleted;

  GetTodoModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.id,
    this.title,
    this.description,
    this.isCompleted,
  });

  factory GetTodoModel.fromJson(Map<String, dynamic> json) => GetTodoModel(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "id": id,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
  };
}
