import '../../domain/api_response.dart';

class AppResponse<T extends BaseResponse> {
  int code;
  String status;
  String copyright;
  String attributionText;
  String etag;
  T result;
  List<T> results;

  AppResponse(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.etag,
      this.result,
      this.results});

  AppResponse.fromJson(Map<String, dynamic> json, BaseResponse object,
      {bool isList = false}) {
    if (json != null) {
      code = json['code'];
      status = json['status'];
      copyright = json['copyright'];
      attributionText = json['attributionText'];
      etag = json['etag'];
      if (isList) {
        results = (resultMap(json) as List)
            ?.map((e) => e == null
                ? null
                : object.fromJson(e as Map<String, dynamic>) as T)
            ?.toList();
      } else {
        result = resultMap(json) == null
            ? null
            : object.fromJson(resultMap(json) as Map<String, dynamic>);
      }
    }
  }

  dynamic resultMap(Map<String, dynamic> json) {
    if (json['data'] == null) return json['data'];
    return json['data'];
  }
}
