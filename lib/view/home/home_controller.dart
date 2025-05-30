import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/model/get_todo_model.dart';

import '../../data/repositories/home_repository.dart';

class HomeController extends GetxController{
  RxBool isLoading = false.obs;

  RxList<GetTodoModel> todoList = <GetTodoModel>[].obs;

@override
  void onReady() {
    super.onReady();
    fetchData();
  }

   void fetchData() async {
    await HomeRepository.getTodoList( isLoader: isLoading);
  }
}