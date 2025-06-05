import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/model/get_todo_model.dart';

import '../../data/repositories/home_repository.dart';
import '../../utils/local_storage.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxInt itemLimit = 10.obs;
  RxBool nextPageAvailable = true.obs;
  RxBool paginationLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RxList<GetTodoModel> todoList = <GetTodoModel>[].obs;
  RxString deletingTodoId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    HomeRepository.getTodoList(isLoader: isLoading);

    manageScrollController();
  }

  void manageScrollController() async {
    scrollController.addListener(
          () async {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          if (nextPageAvailable.isTrue && paginationLoading.isFalse) {
            await HomeRepository.getTodoList(isLoader: paginationLoading,isInitial: false);
          }
        }
      },
    );
  }
  RxSet<String> selectedTodoIds = <String>{}.obs;

  bool isTodoSelected(String? id) => selectedTodoIds.contains(id);

  void toggleSelection(String id) {
    if (selectedTodoIds.contains(id)) {
      selectedTodoIds.remove(id);
    } else {
      selectedTodoIds.add(id);
    }
  }

  void clearSelection() {
    selectedTodoIds.clear();
  }
}
