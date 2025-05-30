import 'package:dio/dio.dart';

import '../../utils/local_storage.dart';
import '../../utils/utils.dart';
import '../handler/app_environment.dart';
import '../services/notification/notification_enum.dart';
import 'api_class.dart';

class APIFunction {
  APIFunction._();

  static const _defaultTimeout = Duration(seconds: 7);

  /// SHARED API CALL LOGIC
  static Future<dynamic> _apiCall({
    required Future<dynamic> Function() request,
  }) async {
    if (await getConnectivityResult()) {
      return await request();
    }
  }

  /// Helper to build the full API URL
  static String _getUrl(String apiName, bool withBaseUrl, {String? versionCode}) {
    return withBaseUrl ? "$apiName" : apiName;
  }

  /// Helper to create Dio Options with headers and timeout
  static Options _getOptions(Duration? receiveTimeout) {
    return Options(
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      headers: {
        "Content-Type": "application/json",
         "Authorization": "Bearer ${LocalStorage.accessToken.value}",
      },
    );
  }

  /// TO CALL POST API
  static Future<dynamic> postApiCall({
    required String apiName,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    String? versionCode,
    NotificationType? sheetType,
  }) async {
    return _apiCall(
      request: () => HttpUtil(errorToast: showErrorToast).post(
        _getUrl(apiName, withBaseUrl, versionCode: versionCode),
        isDecode: isDecode ?? false,
        sheetType: sheetType,
        body: body,
        queryParameters: params,
        options: _getOptions(receiveTimeout),
      ),
    );
  }

  /// TO CALL PUT API
  static Future<dynamic> putApiCall({
    required String apiName,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    String? versionCode,
    bool? showResponseLog,
    bool? showRequestLog,
    NotificationType? sheetType,
  }) async {
    return _apiCall(
      request: () => HttpUtil(errorToast: showErrorToast, showResponseBody: showResponseLog, showRequestLogs: showRequestLog).put(
        _getUrl(apiName, withBaseUrl, versionCode: versionCode),
        isDecode: isDecode ?? false,
        sheetType: sheetType,
        body: body,
        queryParameters: params,
        options: _getOptions(receiveTimeout),
      ),
    );
  }

  /// TO CALL GET API
  static Future<dynamic> getApiCall({
    required String apiName,
    dynamic body,
    bool? isDecode,
    dynamic params,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    String? versionCode,
    bool? showResponseLog,
    bool? showRequestLog,
    NotificationType? sheetType,
  }) async {
    return _apiCall(
      request: () => HttpUtil(errorToast: showErrorToast, showResponseBody: showResponseLog, showRequestLogs: showRequestLog).get(
        _getUrl(apiName, withBaseUrl, versionCode: versionCode),
        body: body,
        sheetType: sheetType,
        queryParameters: params,
        isDecode: isDecode ?? false,
        options: _getOptions(receiveTimeout),
      ),
    );
  }

  /// TO CALL DELETE API
  static Future<dynamic> deleteApiCall({
    required String apiName,
    dynamic body,
    dynamic params,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
    String? versionCode,
    bool? showResponseLog,
    bool? showRequestLog,
    NotificationType? sheetType,
  }) async {
    return _apiCall(
      request: () => HttpUtil(errorToast: showErrorToast, showResponseBody: showResponseLog, showRequestLogs: showRequestLog).delete(
        _getUrl(apiName, withBaseUrl, versionCode: versionCode),
        body: body,
        isDecode: isDecode ?? false,
        sheetType: sheetType,
        queryParameters: params,
        options: _getOptions(receiveTimeout),
      ),
    );
  }
}
