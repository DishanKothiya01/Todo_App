// // To parse this JSON data, do
// //
// //     final getUserData = getUserDataFromJson(jsonString);
//
// import 'dart:convert';
//
// List<GetUserDataModel> getUserDataFromJson(String str) => List<GetUserDataModel>.from(json.decode(str).map((x) => GetUserDataModel.fromJson(x)));
//
// String getUserDataToJson(List<GetUserDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class GetUserDataModel {
//   final String? name;
//   final String? email;
//   final int? phoneNumber;
//   final String? id;
//
//   GetUserDataModel({
//     this.name,
//     this.email,
//     this.phoneNumber,
//     this.id,
//   });
//
//   factory GetUserDataModel.fromJson(Map<String, dynamic> json) => GetUserDataModel(
//     name: json["name"],
//     email: json["email"],
//     phoneNumber: json["phoneNumber"],
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "email": email,
//     "phoneNumber": phoneNumber,
//     "id": id,
//   };
// }
import 'dart:convert';

/// Use this when you receive a raw JSON string response
List<GetUserDataModel> getUserDataFromJson(String str) =>
    List<GetUserDataModel>.from(json.decode(str).map((x) => GetUserDataModel.fromJson(x)));

/// Use this when you already have a decoded list (from Dio)
List<GetUserDataModel> getUserDataFromList(dynamic jsonList) =>
    List<GetUserDataModel>.from(jsonList.map((x) => GetUserDataModel.fromJson(x)));

/// Use this to convert a list back to JSON string
String getUserDataToJson(List<GetUserDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserDataModel {
  final String? name;
  final String? email;
  final num? phoneNumber;
  final String? id;

  GetUserDataModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.id,
  });

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) {
    return GetUserDataModel(
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      id: json["id"], // ensure ID is always a string
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "id": id,
  };
}
