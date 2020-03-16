import 'package:tencent_im_plugin/enums/image_type.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 图片实体
class ImageEntity {
  /// 大小
  int size;

  /// 宽度
  int width;

  /// 类型
  ImageType type;

  /// uuid
  String uuid;

  /// url
  String url;

  /// 高度
  int height;

  ImageEntity({
    this.size,
    this.width,
    this.type,
    this.uuid,
    this.url,
    this.height,
  });

  ImageEntity.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    width = json['width'];
    type = EnumUtil.nameOf(ImageType.values, json["type"]);
    uuid = json['uuid'];
    url = json['url'];
    height = json['height'];
  }
}
