import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/res/app_button.dart';
import 'package:todo_app/res/app_colors.dart';
import 'package:todo_app/res/app_text_field.dart';
import 'package:todo_app/utils/app_text_style.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/add_data/add_data_controller.dart';

class AddDataScreen extends StatelessWidget {
  AddDataScreen({super.key});

  final AddDataController con = Get.put(AddDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD DATA',
          style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundDark),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(defaultRadius),
          child: Column(
            children: [
              AppTextField(
                labelText: 'Title',
                controller: con.task.value,
                validation: con.taskValidation.value,
                errorMessage: con.taskError.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  con.taskValidation.value = true;
                  con.checkDisableButton();
                },
              ),
              (defaultPadding / 2).verticalSpace,
              AppTextField(
                labelText: 'Sub Title',
                controller: con.subTask.value,
                validation: con.subTaskValidation.value,
                errorMessage: con.subTaskError.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  con.subTaskValidation.value = true;
                  con.checkDisableButton();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 130,
        child: Column(
          children: [
            AppButton(
              onPressed: () {
                if (con.validation()) {
                  con.clearData();
                  Get.back();
                }
              },
              title: 'Save',
              backgroundColor: AppColors.kPrimaryColor,
              titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight),
            ),
            (defaultPadding / 2).verticalSpace,
            AppButton(
              onPressed: () {
                con.clearData();
              },
              title: 'Cancel',
              backgroundColor: AppColors.redColor,
              titleStyle: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundLight),
            ),
          ],
        ),
      ),
    );
  }
}
