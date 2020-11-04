import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 群类型
enum GroupTypeEnum {
  /// 工作群
  Work,

  /// 公开群
  Public,

  /// 会议群
  Meeting,

  /// 直播群
  AVChatRoom,
}

class GroupTypeTool {
  /// 根据字符串类型值获得枚举
  /// [type] 字符串常量
  /// [Return] 枚举对象
  static GroupTypeEnum getByString(String type) =>
      EnumUtil.nameOf(GroupTypeEnum.values, type);

  /// 将枚举转换为整型
  static String toTypeString(GroupTypeEnum type) => EnumUtil.getEnumName(type);
}
