import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/model/get_user_data_model.dart';

import '../../data/repositories/home_repository.dart';

class HomeController extends GetxController{
  RxBool isLoading = true.obs;

  RxList<GetUserDataModel> categoryList = <GetUserDataModel>[].obs;

@override
  void onReady() {
    super.onReady();
    fetchData();
  }

   void fetchData() async {
    await HomeRepository.getUserList( isLoader: isLoading);
  }
}