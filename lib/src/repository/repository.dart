import '../business logics/models/api_response_object.dart';
import '../services/api_service/all_attributes_api_services.dart';

class _Repository{

   final _attributesApiServices = AttributesResponseApiServices();

   Future<ResponseObject> getAllAttributes() =>
       _attributesApiServices.getAllAttributes();



}

final repository = _Repository();