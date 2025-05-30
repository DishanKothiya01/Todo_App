import 'package:get/get.dart';
import 'package:todo_app/view/home/home_controller.dart';
import '../../utils/color_print.dart';
import '../../utils/utils.dart';
import '../api/api_function.dart';
import '../handler/api_url.dart';
import '../model/get_user_data_model.dart';

class HomeRepository {
  HomeRepository._();

  /// ***********************************************************************************
  /// *                              GET USER LIST                                   *
  /// ***********************************************************************************

  static Future<void> getUserList({
    RxBool? isLoader,
    bool isInitial = true,
    bool backgroundMode = false,
  }) async {
    if (await getConnectivityResult(isLoader: isLoader)) {
      // try {
        if (!backgroundMode) {
          isLoader?.value = true;
        }

        return await APIFunction.getApiCall(
          apiName: ApiUrls.getMockUser,
        ).then((response) async {
          if (response != null && response['success'] == true) {
            GetUserDataModel userListModel = GetUserDataModel.fromJson(response);

            if (isRegistered<HomeController>()) {
              final HomeController con = Get.find<HomeController>();
              // con.categoryList.value.assignAll(userListModel);
              con.categoryList.add(userListModel);
            }

            isLoader?.value = false;
          }
          isLoader?.value = false;
        });
      // } catch (e) {
      //   isLoader?.value = false;
      //   printErrors(type: "getUserList", errText: e);
      // }
    }
  }
}
