import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/data/repositories/home_repository.dart';
import 'package:todo_app/res/app_button.dart';
import 'package:todo_app/res/app_colors.dart';
import 'package:todo_app/res/app_text_field.dart';
import 'package:todo_app/utils/app_text_style.dart';
import 'package:todo_app/utils/color_print.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/add_data/add_data_controller.dart';

import '../../data/model/get_todo_model.dart';
import '../../res/app_custom_color.dart';
import '../../utils/local_storage.dart';
import '../home/home_controller.dart';

class AddDataScreen extends StatelessWidget {
  AddDataScreen({super.key});

  final AddDataController con = Get.put(AddDataController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundLight,
          title: Text(
            con.isEdit == false ? 'Add Data' : 'Update Data',
            style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundDark).copyWith(fontFamily: 'Inter-Bold'),
          ),
        ),
        body: Container(
          color: AppColors.backgroundLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultRadius * 2).copyWith(top: defaultPadding / 2),
            child: Column(
              children: [
                AppTextField(
                  labelText: 'Title',
                  controller: con.title.value,
                  validation: con.titleValidation.value,
                  errorMessage: con.titleError.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  enabled: con.isCompleted.value ? false : true,
                  onChanged: (value) {
                    con.titleValidation.value = true;
                    con.checkDisableButton();
                  },
                ),
                (defaultPadding).verticalSpace,
                AppTextField(
                  labelText: 'Description',
                  controller: con.description.value,
                  validation: con.descriptionValidation.value,
                  errorMessage: con.descriptionError.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  enabled: con.isCompleted.value ? false : true,
                  minLines: 1,
                  maxLines: 5,
                  onChanged: (value) {
                    con.descriptionValidation.value = true;
                    con.checkDisableButton();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.backgroundLight,
          height: 140.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!con.isCompleted.value)
                AppButton(
                  loader: con.isLoading.value,
                  loaderColor: AppColors.backgroundLight,
                  onPressed: () async {
                    if (con.isEdit == false) {
                      if (con.validation()) {
                        FocusScope.of(context).unfocus();
                        con.isLoading.value = true;
                        con.isSave = true;

                        /// CREATE TODO-DATA API
                        await HomeRepository.createTodoApi(
                          isLoader: con.isLoading,
                          title: con.title.value.text,
                          description: con.description.value.text,
                          isCompleted: false,
                          onSuccess: (newId) async {
                            if (isRegistered<HomeController>()) {
                              final HomeController homeController = Get.find<HomeController>();

                              homeController.todoList.add(
                                GetTodoModel(
                                  id: newId,
                                  title: con.title.value.text.trim(),
                                  description: con.description.value.text.trim(),
                                  isCompleted: false,
                                ),
                              );
                              LocalStorage.savePendingTodo(
                                GetTodoModel(
                                  id: newId,
                                  title: con.title.value.text.trim(),
                                  description: con.description.value.text.trim(),
                                  isCompleted: false,
                                ),
                              );
                              // homeController.todoList.refresh();
                            }
                            con.clearData();
                            Get.back();
                          },
                        );
                      }
                    } else {
                      if (con.validation()) {
                        FocusScope.of(context).unfocus();
                        con.isSave = true;
                        /// UPDATE A TODO DATA
                        await HomeRepository.upDateTodoApi(
                          todoId: con.todoId,
                          isLoader: con.isLoading,
                          title: con.title.value.text.trim(),
                          description: con.description.value.text.trim(),
                          isCompleted: con.isCompleted.value,
                          onSuccess: () async {
                            if (isRegistered<HomeController>()) {
                              final HomeController homeController = Get.find<HomeController>();
                              int index = homeController.todoList.indexWhere((e) => e.id == con.todoId);
                              if (index != -1) {
                                homeController.todoList[index] = GetTodoModel(
                                  id: con.todoModel.id,
                                  title: con.title.value.text.trim(),
                                  description: con.description.value.text.trim(),
                                  isCompleted: con.todoModel.isCompleted,
                                );
                                LocalStorage.updatePendingTodoById(
                                  con.todoId,
                                  GetTodoModel(
                                    id: con.todoId,
                                    title: con.title.value.text,
                                    description: con.description.value.text,
                                    isCompleted: con.isCompleted.value,
                                  ),
                                );

                                homeController.todoList.refresh();
                              }
                              con.isLoading.value = false;
                            }
                            con.clearData();
                            Get.back();
                          },
                        );
                      }
                    }
                  },
                  title: con.isEdit ? 'Update' : 'Save',
                  backgroundColor: AppColors.kPrimaryColor,
                  titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight).copyWith(fontFamily: 'Inter-Bold', fontSize: 20),
                ),
              (defaultPadding).verticalSpace,
              AppButton(
                title: con.isCompleted.value ? 'Back' : 'Cancel',
                backgroundColor: AppColors.redColor,
                disableButton: con.isSave? true : false,
                titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight).copyWith(fontFamily: 'Inter-Bold', fontSize: 20),
                onPressed: () {
                  con.clearData();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
