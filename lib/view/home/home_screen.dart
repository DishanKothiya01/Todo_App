import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/repositories/home_repository.dart';
import 'package:todo_app/res/pull_to_refresh_indicator.dart';
import 'package:todo_app/utils/appAssets.dart';
import 'package:todo_app/utils/app_text_style.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/home/home_controller.dart';
import '../../data/model/get_todo_model.dart';
import '../../res/app_colors.dart';
import '../../utils/local_storage.dart';
import '../../utils/routs/app_routs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              GestureDetector(
                onTap: () {
                  LocalStorage.clearPendingTodos();
                  if (Get.isRegistered<HomeController>()) {
                    final controller = Get.find<HomeController>();
                    controller.todoList.clear();
                  }
                },
                child: Container(
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
                ),
              )
            ],
          )),
      body: Container(
        color: AppColors.gradientEnd.withAlpha(50),
        child: Obx(
          () => con.isLoading.isFalse
              ? con.todoList.isNotEmpty
                  ? PullToRefreshIndicator(
                      onRefresh: () async => await HomeRepository.getTodoList(isLoader: con.isLoading),
                      child: ListView(
                        controller: con.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                                        onTap: () async {
                                          final updatedValue = !(data.isCompleted ?? false);
                                          final updatedTodo = GetTodoModel(
                                            id: data.id,
                                            title: data.title,
                                            description: data.description,
                                            isCompleted: updatedValue,
                                          );

                                          int index = con.todoList.indexWhere((item) => item.id == data.id);

                                          if (index != -1) {
                                            con.todoList[index] = updatedTodo;
                                            HomeRepository.upDateTodoApi(
                                              title: data.title ?? '',
                                              description: data.description ?? '',
                                              isCompleted: updatedValue,
                                              todoId: data.id.toString() ?? "",
                                            );
                                          }
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
                                              ),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              '${data.description}',
                                              style: AppTextStyle.subtitleStyle(context)?.copyWith(
                                                color: data.isCompleted == true ? AppColors.textGreyColor : AppColors.textGreyDark,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                decoration: data.isCompleted == true ? TextDecoration.lineThrough : null,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.addDataScreen, arguments: {
                                            'todoModel': data,
                                            'id': data.id,
                                            'isEdit': true,
                                          });
                                        },
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
                                        onTap: () async {
                                          con.deletingTodoId.value = data.id ?? "";

                                          await HomeRepository.deleteTodoDataApi(
                                            todoId: data.id ?? "",
                                          );
                                          con.deletingTodoId.value = '';
                                        },
                                        child: Obx(() {
                                          final isLoading = con.deletingTodoId.value == data.id;
                                          return CircleAvatar(
                                            backgroundColor: AppColors.redColor.withAlpha(60),
                                            child: isLoading
                                                ? SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator(strokeWidth: 2),
                                                  )
                                                : Image.asset(
                                                    AppAssets.deleteIcon,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          if (con.paginationLoading.isTrue)
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    )
                  : Center(child: Text('Data Not Found'))
              : Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addDataScreen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
