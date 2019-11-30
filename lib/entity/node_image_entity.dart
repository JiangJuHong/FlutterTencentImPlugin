import 'node_entity.dart';

/// 图片节点
class NodeImageEntity extends NodeEntity {
  // 图片类型
  int imageFormat;

  // 原图本地文件路径，发送方有效
  String path;

  // 图片质量级别，0: 原图发送 1: 高压缩率图发送(图片较小) 2:高清图发送(图片较大)
  int level;

  // 图片列表，根据类型分开
  Map<ImageType, ImageEntity> imageData;

  // 图片上传任务id, 调用sendMessage后此接口的返回值有效
  int taskId;

  NodeImageEntity(
      {this.imageFormat, this.path, this.level, this.imageData, this.taskId});

  NodeImageEntity.fromJson(Map<String, dynamic> json) {
    type = NodeEntity.fromJson(json).type;
    imageFormat = json['imageFormat'];
    path = json['path'];
    level = json['level'];
    if (json['imageList'] != null) {
      imageData = Map();
      (json['imageList'] as List).forEach((v) {
        ImageEntity imageEntity = new ImageEntity.fromJson(v);
        if (imageEntity != null) {
          imageData[imageEntity.type] = imageEntity;
        }
      });
    }
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['imageFormat'] = this.imageFormat;
    data['path'] = this.path;
    data['level'] = this.level;
    if (this.imageData != null) {
      data['imageList'] =
          this.imageData.keys.map((v) => this.imageData[v].toJson()).toList();
    }
    data['taskId'] = this.taskId;
    return data;
  }
}

/// 图片实体
class ImageEntity {
  // 大小
  int size;

  // 宽度
  int width;

  // 类型
  ImageType type;

  // uuid
  String uuid;

  // url
  String url;

  // 高度
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
    for (var item in ImageType.values) {
      if (item.toString().replaceFirst("ImageType.", "") == json['type']) {
        type = item;
        break;
      }
    }
    uuid = json['uuid'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['width'] = this.width;
    data['type'] = this.type.toString();
    data['uuid'] = this.uuid;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

/// 图片类型
enum ImageType {
  // 大图
  Large,

  // 原图
  Original,

  // 缩略图
  Thumb,
}
