import 'dart:io';

import 'app_environment.dart';

class ApiUrls {
  ApiUrls._();

  ///* =-=-=-=-=-=-= BASE URL =-=-=-=-=-=-=-=-=-=-=>>
  // static String baseUrl({bool ignoreVersion = false, String? versionCode}) => AppEnvironment.getBaseURL(ignoreVersion: ignoreVersion);
  static const String apiV2 = "v2";
  static const String apiV3 = "v3";

  static const String getTodoList = "https://6838316d2c55e01d184c57a5.mockapi.io/v1/todoapp";
  static const String createTodo = "https://6838316d2c55e01d184c57a5.mockapi.io/v1/todoapp";

  static String updateTodo({required String id}) => "https://6838316d2c55e01d184c57a5.mockapi.io/v1/todoapp/$id";
  static String deleteTodo({required String id}) => "https://6838316d2c55e01d184c57a5.mockapi.io/v1/todoapp/$id";
}
