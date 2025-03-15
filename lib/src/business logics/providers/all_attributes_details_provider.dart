import 'package:flutter/material.dart';

import '../../repository/repository.dart';
import '../models/all_attributes_response_model.dart';
import '../models/api_response_object.dart';

class AllAttributeDetailsProvider extends ChangeNotifier{

    bool _getAllAttributesInProgress = false;
    String errorMessage = '';

    AttributesResponseModel _attributesResponseModel =
    AttributesResponseModel();

    bool get getAllAttributesInProgress => _getAllAttributesInProgress;

    AttributesResponseModel get attributesResponseModel => _attributesResponseModel;

    Future<bool> getAllAttributes() async {
        _getAllAttributesInProgress = true;
        notifyListeners();
        final response = await repository.getAllAttributes();
        if (response.id == ResponseCode.SUCCESSFUL) {
            _getAllAttributesInProgress = false;
            _attributesResponseModel = response.object as AttributesResponseModel;
            notifyListeners();
            return true;
        } else {
            _getAllAttributesInProgress  = false;
            notifyListeners();
            errorMessage = response.object as String;
            return false;
        }
    }


}