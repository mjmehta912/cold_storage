import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/header_data.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response?> postRequest({
    required String endPoint,
    dynamic requestModel,
    bool isShowLoader = true,
    // Map<String, String>? headers,
  }) async {
    // if (await checkUserConnection()) {
    debugPrint("REQUEST MODEL :: $requestModel");

    // Map<String, String>? headers = {};
    if (isShowLoader) {
      Get.find<AlertMessageUtils>().showProgressDialog();
    }

    // headers ??= {'Content-Type': 'application/json'};
    var headers = await HeaderData().headers();
    debugPrint('headers : $headers');
    var domainUrl = ApiConstants.baseUrl;

    var url = Uri.parse('$domainUrl$endPoint');

    debugPrint('url : $url');
    try {
      var response = await http.post(url, body: requestModel, headers: headers);
      debugPrint('response :  ${response.body}');
      return response;
    } catch (e) {
      LoggerUtils.logException('postRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideProgressDialog();
      }
    }
    // }
    // else {
    //   showInternetConnectivityDialog();
    //   return null;
    // }
    return null;
  }

  Future<http.Response?> getRequest({
    required String endPoint,
    Map<String, dynamic>? params,
    bool isShowLoader = true,
    String? baseUrl,
    // Map<String, String>? headers,
  }) async {
    // if (await checkUserConnection()) {
    debugPrint("REQUEST MODEL :: $params");

    // Map<String, String>? headers = {};
    if (isShowLoader) {
      Get.find<AlertMessageUtils>().showProgressDialog();
    }

    // headers ??= {'Content-Type': 'application/json'};
    var headers = await HeaderData().headers();
    debugPrint("headers :: $headers");

    var domainUrl = baseUrl ?? ApiConstants.baseUrl;

    var url = Uri.parse('$domainUrl$endPoint');

    debugPrint('getRequest : $url');
    try {
      var response = await http.get(url, headers: headers);
      debugPrint('response :  ${response.body}');
      return response;
    } catch (e) {
      LoggerUtils.logException('getRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideProgressDialog();
      }
    }
    // } else {
    //   showInternetConnectivityDialog();
    //   return null;
    // }
    return null;
  }

  // Future<http.Response?> deleteRequest({
  Future<String?> deleteRequest({
    required String endPoint,
    dynamic requestModel,
    Map<String, dynamic>? params,
    bool isShowLoader = true,
    // Map<String, String>? headers,
  }) async {
    // if (await checkUserConnection()) {
    debugPrint("REQUEST MODEL :: $requestModel");

    // Map<String, String>? headers = {};
    if (isShowLoader) {
      Get.find<AlertMessageUtils>().showProgressDialog();
    }

    var headers = await HeaderData().headers();
    var domainUrl = ApiConstants.baseUrl;

    var url = Uri.parse('$domainUrl$endPoint');

    debugPrint('deleteRequest : $url');
    try {
      var response =
          await http.delete(url, headers: headers, body: requestModel);
      debugPrint('response :  ${response.body}');
      return response.body;
    } catch (e) {
      LoggerUtils.logException('deleteRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideProgressDialog();
      }
      // }}else {
      // showInternetConnectivityDialog();
      // return null;
      // }
    }
    return null;
  }
}
