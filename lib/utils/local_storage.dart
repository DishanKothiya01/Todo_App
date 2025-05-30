import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/data/model/get_todo_model.dart';

class Pref {
  static const String todoListKey = "TODO_LIST";
}

class LocalStorage {
  static RxString accessToken = "".obs;

  static final prefs = GetStorage();

  static void saveTodoList(List<GetTodoModel> todos) {
    final jsonList = todos.map((e) => e.toJson()).toList();
    prefs.write(Pref.todoListKey, jsonList);
  }

  static List<GetTodoModel> loadTodoList() {
    final jsonList = prefs.read<List>(Pref.todoListKey) ?? [];
    return jsonList.map((e) => GetTodoModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  static void clearTodoList() {
    prefs.remove(Pref.todoListKey);
  }
}
