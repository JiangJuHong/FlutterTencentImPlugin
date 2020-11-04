import 'dart:convert';

import 'entity_factory.dart';

class ListUtil {
  /// 根据泛型生成集合
  static List<T> generateOBJList<T>(arr) {
    if (arr is String) {
      arr = jsonDecode(arr);
    }

    List<T> data = [];
    for (var item in arr) {
      data.add(EntityFactory.generateOBJ<T>(item));
    }
    return data;
  }
}
