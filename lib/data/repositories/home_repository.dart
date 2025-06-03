import 'package:get/get.dart';
import 'package:todo_app/utils/local_storage.dart';
import 'package:todo_app/view/home/home_controller.dart';
import '../../utils/color_print.dart';
import '../../utils/utils.dart';
import '../api/api_function.dart';
import '../handler/api_url.dart';
import '../model/get_todo_model.dart';

class HomeRepository {
  HomeRepository._();

  /// ***********************************************************************************
  /// *                              GET TODOLIST                                       *
  /// ***********************************************************************************
  static Future<void> getTodoList({
    RxBool? isLoader,
    bool isInitial = true,
    bool backgroundMode = false,
  }) async {
    if (isRegistered<HomeController>()) {
      final HomeController con = Get.find<HomeController>();
      if (await getConnectivityResult(isLoader: isLoader)) {
        try {
          if (!backgroundMode) {
            isLoader?.value = true;
          }
          if (isInitial) {
            if (!backgroundMode) {
              con.todoList.clear();
            }
            con.page.value = 1;
            con.nextPageAvailable.value = true;
          }
          return await APIFunction.getApiCall(
            apiName: ApiUrls.getTodoList,
          ).then(
            (response) async {
              if (response != null) {
                List tempList = response;

                con.todoList.value = tempList.map((e) => GetTodoModel.fromJson(e)).toList();

                con.page.value++;
                // con.nextPageAvailable.value = model.data?.page != model.data?.totalPages;

                isLoader?.value = false;
              }
              isLoader?.value = false;
            },
          );
        } catch (e) {
          isLoader?.value = false;
          printErrors(type: "getUserList", errText: e);
        }
      } else {
        con.todoList.value = LocalStorage.loadPendingTodoList();
      }
    }
  }

  /// ***********************************************************************************
  /// *                               CREATE TODO_DATA                                   *
  /// ***********************************************************************************
  static Future<void> createTodoApi({
    RxBool? isLoader,
    required String title,
    required String description,
    required bool isCompleted,
    Function(String newId)? onSuccess,
  }) async {
    if (await getConnectivityResult(isLoader: isLoader)) {
      try {
        isLoader?.value = true;

        return await APIFunction.postApiCall(
          apiName: ApiUrls.createTodo,
          body: {
            "title": title,
            "description": description,
            "isCompleted": isCompleted,
          },
        ).then(
          (response) {
            if (response != null && response['id'] != null) {
              final String newId = response['id'].toString();

              onSuccess?.call(newId);
              isLoader?.value = false;
            }
            isLoader?.value = false;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "createTODO Data Function", errText: e);
      }
    } else {
      if (isRegistered<HomeController>()) {
        final HomeController homeController = Get.find<HomeController>();

        LocalStorage.savePendingTodo(
          GetTodoModel(
            id: (homeController.todoList.length).toString(),
            title: title,
            description: description,
            isCompleted: isCompleted,
          ),
        );
        homeController.todoList.add(
          GetTodoModel(
            id: (homeController.todoList.length).toString(),
            title: title,
            description: description,
            isCompleted: isCompleted,
          ),
        );
        Get.back();
      }
    }
  }

  /// ***********************************************************************************
  /// *                               UPDATE TODO_DATA                                   *
  /// ***********************************************************************************
  static Future<void> upDateTodoApi({
    RxBool? isLoader,
    required String title,
    required String description,
    required bool isCompleted,
    required String todoId,
    Function()? onSuccess,
  }) async {
    if (await getConnectivityResult(isLoader: isLoader)) {
      try {
        isLoader?.value = true;
        Map<String, Object> body = {
          "title": title,
          "description": description,
          "isCompleted": isCompleted,
        };

        return await APIFunction.putApiCall(
          apiName: ApiUrls.updateTodo(id: todoId),
          body: body,
        ).then(
          (response) {
            if (response != null) {
              onSuccess?.call();
              isLoader?.value = false;
            }
            isLoader?.value = false;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "UpdateTODO Data Function", errText: e);
      }
    } else {
      if (isRegistered<HomeController>()) {
        final HomeController homeController = Get.find<HomeController>();
        int index = homeController.todoList.indexWhere((e) => e.id == todoId);
        if (index != -1) {
          final updatedTodo = GetTodoModel(
            id: todoId,
            title: title,
            description: description,
            isCompleted: isCompleted,
          );

          homeController.todoList[index] = updatedTodo;
          LocalStorage.updatePendingTodoById(todoId, updatedTodo);
          onSuccess?.call();
          isLoader?.value = false;
        }
      }
    }
  }

  /// ***********************************************************************************
  ///                             DELETE TodoData
  /// ***********************************************************************************

  static Future<dynamic> deleteTodoDataApi({RxBool? isLoader, required String todoId, Function()? onSuccess}) async {
    if (await getConnectivityResult()) {
      try {
        // isLoader?.value = true;

        return await APIFunction.deleteApiCall(
          apiName: ApiUrls.deleteTodo(id: todoId),
        ).then(
          (response) async {
            if (response != null) {
              if (Get.isRegistered<HomeController>()) {
                final HomeController con = Get.find<HomeController>();
                int index = con.todoList.indexWhere((e) => e.id == todoId);
                if (index != -1) {
                  con.todoList.removeAt(index);
                }
              }

              // if (onSuccess != null) onSuccess();
              // isLoader?.value = false;
            }
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "deleteTodoDataApi", errText: e);
      }
    } else {
      if (isRegistered<HomeController>()) {
        final HomeController con = Get.find<HomeController>();
        int index = con.todoList.indexWhere((e) => e.id == todoId);
        if (index != -1) {
          con.todoList.removeAt(index);
          LocalStorage.deletePendingTodoById(todoId);
          onSuccess?.call();
          isLoader?.value = false;
        }
      }
    }
  }
}
