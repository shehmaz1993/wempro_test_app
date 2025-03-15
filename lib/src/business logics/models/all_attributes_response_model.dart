class AttributesResponseModel {
  String? message;
  String? assignmentInstructionUrl;
  String? information;
  JsonResponse? jsonResponse;

  AttributesResponseModel(
      {this.message,
        this.assignmentInstructionUrl,
        this.information,
        this.jsonResponse});

  AttributesResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    assignmentInstructionUrl = json['assignmentInstructionUrl'];
    information = json['information'];
    jsonResponse = json['json_response'] != null
        ? JsonResponse.fromJson(json['json_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['assignmentInstructionUrl'] = assignmentInstructionUrl;
    data['information'] = information;
    if (jsonResponse != null) {
      data['json_response'] = jsonResponse!.toJson();
    }
    return data;
  }
}

class JsonResponse {
  List<Attributes>? attributes;

  JsonResponse({this.attributes});

  JsonResponse.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String? id;
  String? title;
  String? type;
  List<String>? options;

  Attributes({this.id, this.title, this.type, this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['options'] = options;
    return data;
  }
}