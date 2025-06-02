import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/model/get_todo_model.dart';

class AddDataController extends GetxController {
  RxBool isLoading = false.obs;
  RxString todoId = ''.obs;
  RxBool isCompleted = false.obs;

  /// Title Validation And Error Handle
  Rx<TextEditingController> title = TextEditingController().obs;
  RxBool titleValidation = true.obs;
  RxString titleError = "".obs;

  /// Description Validation And Error Handle
  Rx<TextEditingController> description = TextEditingController().obs;
  RxBool descriptionValidation = true.obs;
  RxString descriptionError = "".obs;

  /// Argument Variable
  GetTodoModel todoModel = GetTodoModel();
  int index = 0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['todoModel'].runtimeType == GetTodoModel) {
        todoModel = Get.arguments['todoModel'];
      }
      if (Get.arguments['index'].runtimeType == int) {
        index = Get.arguments['index'];
      }
    }
    _initializeFields();
  }
  void _initializeFields() {
    title.value.text = todoModel.title ?? '';
    description.value.text = todoModel.description ?? '';
    todoId.value = todoModel.id ?? '';
    isCompleted.value = todoModel.isCompleted ?? false;
  }

  bool validation() {
    if (title.value.text.trim().isEmpty) {
      titleError.value = "Please enter Task";
      titleValidation.value = false;
    } else {
      titleValidation.value = true;
    }

    if (description.value.text.trim().isEmpty) {
      descriptionError.value = "Please enter SubTask";
      descriptionValidation.value = false;
    } else {
      descriptionValidation.value = true;
    }

    return descriptionValidation.isTrue && titleValidation.isTrue;
  }

  void checkDisableButton() {
    description.value.text.trim().isNotEmpty && title.value.text.trim().isNotEmpty;
  }

  void clearData() {
    description.value.clear();
    title.value.clear();
  }
}
