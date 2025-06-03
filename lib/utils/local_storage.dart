import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import '../data/model/get_todo_model.dart';

// class LocalStorage {
//   static const String todoListKey = "TODO_LIST";
//   static const String pendingTodoKey = "PENDING_TODO_LIST";
//   static RxString accessToken = "".obs;
//
//   static final prefs = GetStorage();
//
//   /// Save new offline todo
//   static void savePendingTodo(GetTodoModel todo) {
//     List<GetTodoModel> pendingList = loadPendingTodoList();
//     pendingList.add(todo);
//     final jsonList = pendingList.map((e) => e.toJson()).toList();
//     prefs.write(pendingTodoKey, jsonList);
//   }
//
//   /// Load all offline todos
//   static List<GetTodoModel> loadPendingTodoList() {
//     final jsonList = prefs.read<List>(pendingTodoKey) ?? [];
//     return jsonList.map((e) => GetTodoModel.fromJson(Map<String, dynamic>.from(e))).toList();
//   }
//
//   /// Update specific offline todo
//   static void updatePendingTodo(int index, GetTodoModel updatedTodo) {
//     List<GetTodoModel> pendingList = loadPendingTodoList();
//     if (index >= 0 && index < pendingList.length) {
//       pendingList[index] = updatedTodo;
//       prefs.write(pendingTodoKey, pendingList.map((e) => e.toJson()).toList());
//     }
//   }
//
//   /// Delete specific offline todo
//   static void deletePendingTodo(int index) {
//     List<GetTodoModel> pendingList = loadPendingTodoList();
//     if (index >= 0 && index < pendingList.length) {
//       pendingList.removeAt(index);
//       prefs.write(pendingTodoKey, pendingList.map((e) => e.toJson()).toList());
//     }
//   }
//
//   static void clearPendingTodos() {
//     prefs.remove(pendingTodoKey);
//   }
// }

class LocalStorage {
  static const String todoListKey = "TODO_LIST";
  static const String pendingTodoKey = "PENDING_TODO_LIST";
  static const String _todoIdCounterKey = 'todo_id_counter';

  static RxString accessToken = "".obs;

  static final prefs = GetStorage();

  /// Generate unique persistent local todo ID
  static String generateLocalTodoId() {
    final int currentId = prefs.read(_todoIdCounterKey) ?? 0;
    final int newId = currentId + 1;
    prefs.write(_todoIdCounterKey, newId);
    return 'local_$newId';
  }

  /// Save new offline todo
  static void savePendingTodo(GetTodoModel todo) {
    List<GetTodoModel> pendingList = loadPendingTodoList();
    pendingList.add(todo);
    final jsonList = pendingList.map((e) => e.toJson()).toList();
    prefs.write(pendingTodoKey, jsonList);
  }

  /// Load all offline todos
  static List<GetTodoModel> loadPendingTodoList() {
    final jsonList = prefs.read<List>(pendingTodoKey) ?? [];
    return jsonList.map((e) => GetTodoModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  ///  Update specific offline todo by ID
  static void updatePendingTodoById(String id, GetTodoModel updatedTodo) {
    List<GetTodoModel> pendingList = loadPendingTodoList();
    int index = pendingList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      pendingList[index] = updatedTodo;
      prefs.write(pendingTodoKey, pendingList.map((e) => e.toJson()).toList());
    }
  }

  ///  Delete specific offline todo by ID
  static void deletePendingTodoById(String id) {
    List<GetTodoModel> pendingList = loadPendingTodoList();
    pendingList.removeWhere((todo) => todo.id == id);
    prefs.write(pendingTodoKey, pendingList.map((e) => e.toJson()).toList());
  }

  static void toggleIsCompletedById(String id) {
    List<GetTodoModel> pendingList = loadPendingTodoList();

    int index = pendingList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = pendingList[index];
      pendingList[index] = GetTodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: !(todo.isCompleted ?? false),
      );

      prefs.write(pendingTodoKey, pendingList.map((e) => e.toJson()).toList());
    }
  }

  /// Clear all offline todos
  static void clearPendingTodos() {
    prefs.remove(pendingTodoKey);
  }
}
