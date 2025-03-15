import 'package:flutter/material.dart';

import '../../repository/repository.dart';
import '../models/all_attributes_response_model.dart';
import '../models/api_response_object.dart';
import '../utils/log_debugger.dart';

class AllAttributeDetailsProvider extends ChangeNotifier{



    String? selectedPropertyType;
    String? selectedBedrooms;
    String? selectedBathrooms;
    String? selectedCleaningFrequency;
    String? selectedGarage;
    String? selectedOutdoor;
    String? preferredTime;
    bool _getAllAttributesInProgress = false;
    bool selectedGarageValue= false;
    bool selectedOutdoorValue = false;
    String errorMessage = '';
    String? result;
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
            LogDebugger.instance.w(_attributesResponseModel.jsonResponse!.attributes!.first.title);
            return true;
        } else {
            _getAllAttributesInProgress  = false;
            notifyListeners();
            errorMessage = response.object as String;
            return false;
        }
    }
    void updateValue(String field, String? value,[bool? checkValue]) {
        switch (field) {
            case 'propertyType':
                selectedPropertyType = value;
                break;
            case 'bedrooms':
                selectedBedrooms = value;
                break;
            case 'bathrooms':
                selectedBathrooms = value;
                break;
            case 'cleaningFrequency':
                selectedCleaningFrequency = value;
                break;
            case 'garage':
                selectedGarage = value;
                break;
            case 'outdoor':
                selectedOutdoor = value;
                break;
            case 'preferredTime':
                preferredTime = value;
                break;
        }
        notifyListeners();
    }
    setResult(String res){

        result = res;
        notifyListeners();
    }



}