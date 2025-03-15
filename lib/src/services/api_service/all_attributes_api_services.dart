import 'package:wempro_test_app/src/business%20logics/utils/urls.dart';

import '../../business logics/models/all_attributes_response_model.dart';
import '../../business logics/models/api_response_object.dart';
import 'base_api_caller.dart';

class AttributesResponseApiServices{

  Future<ResponseObject> getAllAttributes() async {
    try {
      final response =
      await BaseAPICaller.getRequest(Urls.codingTest);
      if (response.success) {
        return ResponseObject(
            object: AttributesResponseModel.fromJson(response.returnValue),
            id: ResponseCode.SUCCESSFUL);
      } else {
        return ResponseObject(
            object: response.errorMessage, id: ResponseCode.FAILED);
      }
    } catch (e) {
      return ResponseObject(object: e.toString(), id: ResponseCode.FAILED);
    }
  }
}