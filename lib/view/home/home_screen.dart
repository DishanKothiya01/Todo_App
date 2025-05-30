import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        centerTitle: true,
        title: Text(
          'TODO PROJECT',
          style: AppTextStyle.titleStyle(context)?.copyWith(color: AppColors.backgroundDark),
        ),
      ),
      body: Obx(
        () => con.isLoading.isFalse
            ? con.todoList.isNotEmpty
                ? SafeArea(
                    child: ListView.builder(
                      itemCount: con.todoList.length,
                      padding: EdgeInsets.all(defaultPadding / 2),
                      itemBuilder: (context, index) {
                        final data = con.todoList[index];
                        return Container(
                          margin: EdgeInsets.all(defaultPadding / 5),
                          padding: EdgeInsets.all(defaultPadding / 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent.withAlpha(50),
                                Colors.lightBlue.withAlpha(80),
                              ],
                            ),
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(defaultRadius * 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KeyValueWidget(title: 'Title', value: data.title),
                                KeyValueWidget(title: 'Description', value: data.description),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator())
            : Center(child: Text('Data Not Found')),
      ),
    );
  }
}
