//  this is my Screen :
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'home_controller.dart';
//
// class HomeScreen extends StatelessWidget {
//   final HomeController controller = Get.put(HomeController());
//   final TextEditingController textController = TextEditingController();
//
//   HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ToDo App with GetX')),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: textController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter task',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (textController.text.isNotEmpty) {
//                       controller.addTodo(textController.text.trim());
//                       textController.clear();
//                     }
//                   },
//                   child: Text('Add'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: controller.todos.length,
//                 itemBuilder: (_, index) {
//                   final todo = controller.todos[index];
//                   return ListTile(
//                     title: Text(
//                       todo.title ?? '',
//                       style: TextStyle(
//                         decoration:
//                         (todo.isDone ?? false)
//                             ? TextDecoration.lineThrough
//                             : null,
//                       ),
//                     ),
//                     leading: Checkbox(
//                       value: todo.isDone ?? false,
//                       onChanged: (_) => controller.toggleTodo(todo.id ?? ''),
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () => controller.deleteTodo(todo.id ?? ''),
//                     ),
//                     onTap: () {
//                       textController.text = todo.title ?? '';
//                       Get.defaultDialog(
//                         title: 'Edit Todo',
//                         content: TextField(
//                           controller: textController,
//                           decoration: InputDecoration(hintText: 'New title'),
//                         ),
//                         confirm: ElevatedButton(
//                           onPressed: () {
//                             controller.updateTodoTitle(
//                               textController.text.trim(),
//                               todo.id ?? '',
//                             );
//                           },
//                           child: Text('Update'),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
// this is my controller :
// import 'package:get/get.dart';
// import 'package:todo_app/model/todo_model.dart';
// import '../local_storage/local_storage.dart';
// import '../repository/home_repository.dart';
//
// class HomeController extends GetxController {
//   RxList<TodoModel> todos= <TodoModel>[].obs;
//   final api = ApiService();
//   // final uuid = Uuid();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadData();
//   }
//
//   void loadData() async {
//     final local = LocalStorage.loadTodos();
//     todos.value = local;
//   }
//
//   void saveData() {
//     LocalStorage.saveTodos(todos);
//   }
//
//   void addTodo(String title) async {
//     final todo = TodoModel(title: title);
//     await api.createTodo(todo);
//     todos.add(todo);
//     saveData();
//   }
//
//   void toggleTodo(String id) async {
//     final index = todos.indexWhere((t) => t.id == id);
//     if (index != -1) {
//       final todo = todos[index];
//       todo.isDone = todo.isDone ?? false;
//       await api.updateTodo(todo);
//       todos[index] = todo;
//       saveData();
//     }
//   }
//
//   void updateTodoTitle(String id, String newTitle) async {
//     final index = todos.indexWhere((t) => t.id == id);
//     if (index != -1) {
//       final todo = todos[index];
//       todo.title = newTitle;
//       await api.updateTodo(todo);
//       todos[index] = todo;
//       saveData();
//     }
//   }
//
//   void deleteTodo(String id) async {
//     await api.deleteTodo(id);
//     todos.removeWhere((t) => t.id == id);
//     saveData();
//   }
// }
// this is my repository :
// import 'package:dio/dio.dart';
// import 'package:todo_app/model/todo_model.dart';
//
// class ApiService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: 'https://6838316d2c55e01d184c57a5.mockapi.io/v1/'));
//
//   Future<List<TodoModel>> fetchTodos() async {
//     final response = await _dio.get('/todoapp');
//     final getData =
//     (response.data as List).map((e) => TodoModel.fromJson(e)).toList();
//     print(getData);
//     return  getData;
//   }
//
//   Future<TodoModel> createTodo(TodoModel todo) async {
//     final response = await _dio.post('/todoapp', data: todo.toJson());
//     print(response);
//     return TodoModel.fromJson(response.data);
//   }
//
//   Future<TodoModel> updateTodo(TodoModel todo) async {
//     final response = await _dio.put('/todoapp/${todo.id}', data: todo.toJson());
//     return TodoModel.fromJson(response.data);
//   }
//
//   Future<bool> deleteTodo(String id) async {
//     await _dio.delete('/todoapp/$id');
//     return true;
//   }
// }
// this is my local Storage :
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:todo_app/model/todo_model.dart';
//
// class LocalStorage {
//   static final _box = GetStorage();
//   static const _key = 'todos';
//
//   static void saveTodos(List<TodoModel> todos) {
//     final jsonList = todos.map((e) => e.toJson()).toList();
//     _box.write(_key, jsonEncode(jsonList));
//   }
//
//   static List<TodoModel> loadTodos() {
//     final data = _box.read(_key);
//     if (data == null) return [];
//     final decoded = jsonDecode(data);
//     return List<TodoModel>.from(decoded.map((e) => TodoModel.fromJson(e)));
//   }
// }
// this is my model :
// class TodoModel {
//   final String? id;
//   String? title;
//   bool? isDone;
//
//   TodoModel({this.id, this.title, this.isDone});
//
//   factory TodoModel.fromJson(Map<String, dynamic> json) {
//     return TodoModel(id: json['id'], title: json['title'], isDone: json['isDone']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'title': title, 'isDone': isDone};
//   }
// }
