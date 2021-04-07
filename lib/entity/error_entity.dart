import 'dart:convert';

/// 错误实体
class ErrorEntity {
  /// 错误码
  late int code;

  /// 错误描述
  String? error;

  ErrorEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['code'] != null) code = json['code'];
    if (json['error'] != null) error = json['error'];
  }
}
