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

  @override
  void onReady() {
    super.onReady();
    // HomeRepository.getTodoList(isLoader: isLoading);

    fetchData();
  }

  void fetchData() async {
    HomeRepository.getTodoList(isLoader: isLoading);

    // scrollController.addListener(
    //       () async {
    //     if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
    //       if (nextPageAvailable.isTrue && paginationLoading.isFalse) {
    //         await HomeRepository.getTodoList(isLoader: paginationLoading,isInitial: false);
    //         // await OrderHistoryRepository.getOrderHistoryAPI(isLoader: paginationLoading, isInitial: false);
    //       }
    //     }
    //   },
    // );
  }
}
