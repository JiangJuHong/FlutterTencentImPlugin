/// 错误实体
class ErrorEntity {
  /// 错误码
  int code;

  /// 错误描述
  String error;

  ErrorEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
  }
}
