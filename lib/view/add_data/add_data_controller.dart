import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/model/get_todo_model.dart';

class AddDataController extends GetxController {
  RxBool isLoading = false.obs;
  String todoId = '';
  RxBool isCompleted = false.obs;
bool isSave = false;
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
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['todoModel'].runtimeType == GetTodoModel) {
        todoModel = Get.arguments['todoModel'];
      }
      if (Get.arguments['id'].runtimeType == String) {
        todoId = Get.arguments['id'];
      }
      if (Get.arguments['isEdit'].runtimeType == bool) {
        isEdit = Get.arguments['isEdit'];
      }

    }
    _initializeFields();
  }

  void _initializeFields() {
    title.value.text = todoModel.title ?? '';
    description.value.text = todoModel.description ?? '';
    isCompleted.value = todoModel.isCompleted ?? false;
    if (todoId.isEmpty) {
      todoId = todoModel.id ?? '';
    }
  }

  bool validation() {
    if (title.value.text.trim().isEmpty) {
      titleError.value = "Please enter Title";
      titleValidation.value = false;
    } else {
      titleValidation.value = true;
    }

    if (description.value.text.trim().isEmpty) {
      descriptionError.value = "Please enter Description";
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
