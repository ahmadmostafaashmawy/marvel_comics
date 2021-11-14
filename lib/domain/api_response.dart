abstract class BaseResponse<T> {
  T fromJson(Map<String, dynamic> json);
}
