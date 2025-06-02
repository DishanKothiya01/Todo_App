import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/data/repositories/home_repository.dart';
import 'package:todo_app/res/app_button.dart';
import 'package:todo_app/res/app_colors.dart';
import 'package:todo_app/res/app_text_field.dart';
import 'package:todo_app/utils/app_text_style.dart';
import 'package:todo_app/utils/color_print.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/add_data/add_data_controller.dart';

import '../../data/model/get_todo_model.dart';
import '../home/home_controller.dart';

class AddDataScreen extends StatelessWidget {
  AddDataScreen({super.key});

  final AddDataController con = Get.put(AddDataController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gradientEnd.withAlpha(50),
          title: Text(
            con.todoId.isEmpty ? 'ADD DATA' : 'UPDATE DATA',
            style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundDark).copyWith(fontFamily: 'Bodoni'),
          ),
        ),
        body: Container(
          color: AppColors.gradientEnd.withAlpha(50),
          child: Padding(
            padding: const EdgeInsets.all(defaultRadius),
            child: Column(
              children: [
                AppTextField(
                  labelText: 'Title',
                  controller: con.title.value,
                  validation: con.titleValidation.value,
                  errorMessage: con.titleError.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    con.titleValidation.value = true;
                    con.checkDisableButton();
                  },
                ),
                (defaultPadding / 2).verticalSpace,
                AppTextField(
                  labelText: 'Sub Title',
                  controller: con.description.value,
                  validation: con.descriptionValidation.value,
                  errorMessage: con.descriptionError.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
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
          color: AppColors.gradientEnd.withAlpha(50),
          height: 140,
          child: con.todoId.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    con.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton(
                            onPressed: () async {
                              if (con.validation()) {
                                FocusScope.of(context).unfocus();
                                con.isLoading.value = true;

                                /// CREATE TODO-DATA API
                                await HomeRepository.createTodoApi(
                                  isLoader: con.isLoading,
                                  title: con.title.value.text,
                                  description: con.description.value.text,
                                  isCompleted: false,
                                  onSuccess: () async {
                                    final HomeController homeController = Get.find<HomeController>();

                                    homeController.todoList.add(
                                      GetTodoModel(
                                        title: con.title.value.text,
                                        description: con.description.value.text,
                                        isCompleted: false,
                                      ),
                                    );

                                    Get.back();
                                    con.clearData();
                                  },
                                );
                              }
                            },
                            title: 'Save',
                            backgroundColor: AppColors.kPrimaryColor,
                            titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight).copyWith(
                                  fontFamily: 'Bodoni',
                                ),
                          ),
                    (defaultPadding / 2).verticalSpace,
                    AppButton(
                      onPressed: () {
                        con.clearData();
                      },
                      title: 'Cancel',
                      backgroundColor: AppColors.redColor,
                      titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight).copyWith(
                            fontFamily: 'Bodoni',
                          ),
                    ),
                  ],
                )
              : Center(
                  child: con.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AppButton(
                          onPressed: () async {
                            if (con.validation()) {
                              FocusScope.of(context).unfocus();
                              con.isLoading.value = true;

                              /// UPDATE A TODO DATA
                              await HomeRepository.upDateTodoApi(
                                todoId: con.todoId.value,
                                isLoader: con.isLoading,
                                title: con.title.value.text,
                                description: con.description.value.text,
                                isCompleted: con.isCompleted.value,
                                onSuccess: () async {
                                  final HomeController homeController = Get.find<HomeController>();
                                  homeController.todoList[con.index] = GetTodoModel(
                                    id: con.todoModel.id,
                                    title: con.title.value.text,
                                    description: con.description.value.text,
                                    isCompleted: con.todoModel.isCompleted,
                                  );

                                  con.clearData();
                                  homeController.todoList.refresh();
                                },
                              );
                              Get.back();
                            }
                          },
                          title: 'UPDATE',
                          backgroundColor: AppColors.kPrimaryColor,
                          titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight).copyWith(
                                fontFamily: 'Bodoni',
                              ),
                        ),
                ),
        ),
      ),
    );
  }
}
