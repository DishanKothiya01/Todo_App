import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/repositories/home_repository.dart';
import 'package:todo_app/res/pull_to_refresh_indicator.dart';
import 'package:todo_app/utils/appAssets.dart';
import 'package:todo_app/utils/app_text_style.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/add_data/add_data_screen.dart';
import 'package:todo_app/view/home/home_controller.dart';

import '../../res/app_colors.dart';
import 'components/key_value_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddDataScreen());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          backgroundColor: AppColors.gradientEnd.withAlpha(50),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Task ...',
                style: AppTextStyle.subtitleStyle(context)?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: AppColors.backgroundDark,
                  fontFamily: 'Bodoni',
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(AppAssets.avtarImage)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0XFF2193b0),
                      Color(0XFF6dd5ed),
                    ],
                  ),
                ),
              )
            ],
          )),
      body: Container(
        color: AppColors.gradientEnd.withAlpha(50),
        child: Obx(
          () => PullToRefreshIndicator(
            onRefresh: () async => await HomeRepository.getTodoList(isLoader: con.isLoading),
            child: con.isLoading.isFalse
                ? con.todoList.isNotEmpty
                    ? SafeArea(
                        child: ListView.builder(
                          itemCount: con.todoList.length,
                          padding: EdgeInsets.all(defaultPadding / 2),
                          itemBuilder: (context, index) {
                            final data = con.todoList[index];
                            return Container(
                              margin: EdgeInsets.all(defaultPadding / 2),
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundLight,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.textFieldBorder,
                                ),
                                borderRadius: BorderRadius.circular(defaultRadius * 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding / 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: ()async {
                                        // handle here data.isCompleted with true and false with toggle
                                      },
                                      child: CircleAvatar(
                                        child: data.isCompleted == true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                size: 25,
                                              )
                                            : Icon(
                                                Icons.circle_outlined,
                                                size: 25,
                                              ),
                                      ),
                                    ),
                                    (defaultPadding / 2).horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data.title}',
                                            style: AppTextStyle.titleStyle(context)?.copyWith(
                                              color: data.isCompleted == true ? AppColors.textGreyColor : AppColors.backgroundDark,
                                              fontSize: 18.sp,
                                              fontFamily: 'Bodoni',
                                              decoration: data.isCompleted == true ? TextDecoration.lineThrough : null,
                                            ),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            '${data.description}',
                                            style: AppTextStyle.subtitleStyle(context)?.copyWith(
                                              color: AppColors.textGreyDark,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              decoration: data.isCompleted == true ? TextDecoration.lineThrough : null,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.secondaryColor.withAlpha(60),
                                        child: Image.asset(
                                          AppAssets.editIcon,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                    (defaultPadding / 2).horizontalSpace,
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.redColor.withAlpha(60),
                                        child: Image.asset(
                                          AppAssets.deleteIcon,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: Text('Data Not Found'))
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
