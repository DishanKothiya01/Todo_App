import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  Rx<TextEditingController> task = TextEditingController().obs;
  RxBool taskValidation = true.obs;
  RxString taskError = "".obs;

  Rx<TextEditingController> subTask = TextEditingController().obs;
  RxBool subTaskValidation = true.obs;
  RxString subTaskError = "".obs;

  bool validation() {
    if (task.value.text.trim().isEmpty) {
      taskError.value = "Please enter Task";
      taskValidation.value = false;
    } else {
      taskValidation.value = true;
    }

    if (subTask.value.text.trim().isEmpty) {
      subTaskError.value = "Please enter SubTask";
      subTaskValidation.value = false;
    } else {
      subTaskValidation.value = true;
    }



    return subTaskValidation.isTrue && taskValidation.isTrue;
  }

  void checkDisableButton() {
    subTask.value.text.trim().isNotEmpty && task.value.text.trim().isNotEmpty ;
  }

  void clearData() {
    subTask.value.clear();
    task.value.clear();
  }
}
