import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_app/data/handler/api_url.dart';
import 'package:todo_app/utils/color_print.dart';
import 'package:todo_app/utils/utils.dart';
import '../services/notification/notification_enum.dart';

class HttpUtil {
  static final HttpUtil _singleton = HttpUtil._internal();
  static bool showErrorToast = true;
  static const _defaultTimeout = Duration(seconds: 7);
  static bool? showResponseLog;
  static bool? showRequestLog;

  late Dio dio;
  late CancelToken cancelToken;
  static String apiUrl = ApiUrls.getTodoList;

  HttpUtil._internal() {
    cancelToken = CancelToken();
    dio = Dio(_createBaseOptions());
    _addInterceptors();
  }

  factory HttpUtil({bool errorToast = true, bool? showResponseBody, bool? showRequestLogs}) {
    showErrorToast = errorToast;
    showResponseLog = showResponseBody;
    showRequestLog = showRequestLogs;
    return _singleton;
  }

  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: _defaultTimeout,
      receiveTimeout: _defaultTimeout,
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
  }

  void _addInterceptors() {
    dio.interceptors.add(CookieManager(CookieJar()));
    dio.interceptors.add(_createPrettyLogger());
    dio.interceptors.add(_createResponseHandler());
  }

  PrettyDioLogger _createPrettyLogger() {
    return PrettyDioLogger(
      request: true,
      requestHeader: false,
      requestBody: true /* (showRequestLog ?? true) */,
      responseHeader: false,
      responseBody: true /* (showResponseLog ?? false) */,
      error: true,
      compact: true,
    );
  }

  InterceptorsWrapper _createResponseHandler() {
    return InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) => handler.next(response),
      onError: (DioException e, handler) {
        _handleError(e);
        handler.next(e);
      },
    );
  }

  void _handleError(DioException e) {
    if (!isValEmpty(e.response)) {
      if (showErrorToast) {
        final subMessage = e.response?.data?['subMessage'] ?? "";
        if (subMessage != "route_not_found") {
          // UiUtils.toast(e.response?.data['message'].toString());
        }
      }
    }
    apiErrorHandler(e.response?.statusCode ?? 0);
    onError(createErrorEntity(e));
  }

  Future<void> apiErrorHandler(int statusCode) async {
    try {
      if (statusCode == 401) {
        debugPrint('AnUthorized');
        // await ConversationSocket.userDisconnectEmit(type: "logout");
        // await ApiUtils.logoutAndCleanAllUserData();
      }
    } catch (e, stackTrace) {
      printWarning(stackTrace.toString());
    }
  }

  void onError(ErrorEntity eInfo) {
    printWarning("Error code: ${eInfo.code}, message: ${eInfo.message}");
    if (showErrorToast && eInfo.message.isNotEmpty) {
      // toast(eInfo.message);
    }
  }

  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request to server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -3, message: "Receive timeout with server");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -4, message: "Send timeout with server");
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final message = _getErrorMessage(statusCode);
        return ErrorEntity(code: statusCode, message: message);
      case DioExceptionType.unknown:
        // return _handleUnknownError(error.message);
      default:
        return ErrorEntity(code: -8, message: "Unknown error occurred");
    }
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Request syntax error";
      case 401:
        return "Permission denied";
      case 403:
        return "Server refuses to execute";
      case 404:
        return "Cannot reach server";
      case 500:
        return "Internal server error";
      default:
        return "Unexpected error occurred";
    }
  }

  // ErrorEntity _handleUnknownError(String? message) {
  //   if (message?.contains("SocketException") ?? false) {
  //     return ErrorEntity(code: -5, message: "Internet is unavailable. Please try again.");
  //   }
  //   return ErrorEntity(code: -7, message: "Something went wrong");
  // }

  Future<dynamic> _makeRequest(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isDecode = false,
    NotificationType? sheetType,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.method = method;

    // Ensure `extra` is not null and include `isDecode`
    requestOptions.extra ??= {};
    requestOptions.extra!['isDecode'] = isDecode;

    // Conditionally encode the body if `isDecode` is true
    final requestData = isDecode ? FormData.fromMap(data) : data;

    final response = await dio.request(
      path,
      data: requestData,
      queryParameters: {
        if (sheetType != null) "sheet_place": sheetType.slug,
        ...?queryParameters,
      },
      options: requestOptions,
      cancelToken: cancelToken,
    );

    final dynamic responseData = response.data;

    if (sheetType != null) {
      if (responseData["bottomSheetAvailable"] != null && responseData["bottomSheetAvailable"] == true) {
        // BottomSheetRepository.getBottomSheetDetailsAPI(typeOfSelectionSlug: sheetType);
      }
    }
    return responseData;
  }

  Future get(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isDecode = false,
    NotificationType? sheetType,
  }) =>
      _makeRequest(path, method: 'GET', data: body, queryParameters: queryParameters, options: options, isDecode: isDecode, sheetType: sheetType);

  Future post(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isDecode = false,
    NotificationType? sheetType,
  }) =>
      _makeRequest(path, method: 'POST', data: body, queryParameters: queryParameters, options: options, isDecode: isDecode, sheetType: sheetType);

  Future put(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isDecode = false,
    NotificationType? sheetType,
  }) =>
      _makeRequest(path, method: 'PUT', data: body, queryParameters: queryParameters, options: options, isDecode: isDecode, sheetType: sheetType);

  Future delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isDecode = false,
    NotificationType? sheetType,
  }) =>
      _makeRequest(path, method: 'DELETE', data: body, queryParameters: queryParameters, options: options, isDecode: isDecode, sheetType: sheetType);
}

class ErrorEntity implements Exception {
  final int code;
  final String message;

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() => "ErrorEntity(code: $code, message: $message)";
}

////
