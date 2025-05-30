import 'package:get/get.dart';
import 'package:todo_app/view/add_data/add_data_screen.dart';
import 'package:todo_app/view/home/home_screen.dart';
import 'app_routs.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.addDataScreen, page: () => AddDataScreen()),

  ];
}
