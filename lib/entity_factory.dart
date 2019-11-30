import 'package:tencent_im_plugin/entity/session_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SessionEntity") {
      return SessionEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}