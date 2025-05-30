import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
    if (await getConnectivityResult(isLoader: isLoader)) {
      try {
        if (!backgroundMode) {
          isLoader?.value = true;
        }
        return await APIFunction.getApiCall(
          apiName: ApiUrls.getTodoList,
        ).then(
          (response) async {
            if (response != null) {
              List tempList = response;
              if (isRegistered<HomeController>()) {
                final HomeController con = Get.find<HomeController>();
                con.todoList.value = tempList.map((e) => GetTodoModel.fromJson(e)).toList();
                isLoader?.value = false;
              }
              isLoader?.value = false;
            }
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "getUserList", errText: e);
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
    Function()? onSuccess,
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
            if (response != null) {
              onSuccess?.call();
              isLoader?.value = false;
            }
            isLoader?.value = false;
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printErrors(type: "createTODO Data Function", errText: e);
      }
    }
  }
}
