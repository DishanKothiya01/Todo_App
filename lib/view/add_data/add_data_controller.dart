import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  RxBool isLoading = false.obs;

  Rx<TextEditingController> title = TextEditingController().obs;
  RxBool titleValidation = true.obs;
  RxString titleError = "".obs;

  Rx<TextEditingController> description = TextEditingController().obs;
  RxBool descriptionValidation = true.obs;
  RxString descriptionError = "".obs;

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
    description.value.text.trim().isNotEmpty && title.value.text.trim().isNotEmpty ;
  }

  void clearData() {
    description.value.clear();
    title.value.clear();
  }
}
