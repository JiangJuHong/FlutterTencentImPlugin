import 'dart:convert';

/// 错误实体
class ErrorEntity {
  /// 错误码
  int code;

  /// 错误描述
  String error;

  ErrorEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    code = json['code'];
    error = json['error'];
  }
}
