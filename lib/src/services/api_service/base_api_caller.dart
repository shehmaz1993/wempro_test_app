import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../business logics/utils/log_debugger.dart';

class RequestReturnObject {
  bool success;
  dynamic returnValue;
  String errorMessage;
  int responseCode;

  RequestReturnObject({required this.errorMessage, required this.returnValue, required this.success, required this.responseCode});
}

class BaseAPICaller {

  BaseAPICaller._internal();

  // get api caller
  static Future<RequestReturnObject> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final request = http.MultipartRequest('GET', uri);
      request.headers['Accept'] = 'application/json';


      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData0 = await response.stream.transform(utf8.decoder)
            .join();
        final decodedJson = json.decode(responseData0);
        LogDebugger.instance.w(decodedJson);
        return RequestReturnObject(
            errorMessage: '',
            returnValue: decodedJson,
            success: true,
            responseCode: response.statusCode);
      } else if (response.statusCode == 401) {
        return RequestReturnObject(
            errorMessage: 'Response code ${response.statusCode}',
            returnValue: '',
            success: false,
            responseCode: response.statusCode
        );
      } else {
        final responseData = await response.stream.transform(utf8.decoder)
            .join();
        final decodedJson = json.decode(responseData);
        LogDebugger.instance.w(decodedJson);
        LogDebugger.instance.e(e);
        return RequestReturnObject(
            errorMessage: 'Response code ${response.statusCode}',
            returnValue: decodedJson,
            success: false,
            responseCode: response.statusCode);
      }
    } catch (e) {
      return RequestReturnObject(
          errorMessage: e.toString(),
          returnValue: "",
          success: false,
          responseCode: 400);
    }
  }
}