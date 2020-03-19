import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/image_type.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'entity/image_entity.dart';

/// 图片消息节点
class ImageMessageNode extends MessageNode {
  /// 图片路径
  String path;

  /// 图片类型
  int imageFormat;

  /// 图片质量级别，0: 原图发送 1: 高压缩率图发送(图片较小) 2:高清图发送(图片较大)
  int level;

  /// 图片列表，根据类型分开
  Map<ImageType, ImageEntity> imageData;

  ImageMessageNode({
    @required this.path,
    this.level: 1,
  }) : super(MessageNodeType.Image);

  ImageMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.Image) {
    imageFormat = json['imageFormat'];
    path = json['path'];
    level = json['level'];
    if (json['imageData'] != null) {
      imageData = Map();
      (json['imageData'] as List).forEach((v) {
        ImageEntity imageEntity = new ImageEntity.fromJson(v);
        if (imageEntity != null) {
          imageData[imageEntity.type] = imageEntity;
        }
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    data["level"] = this.level;
    return data;
  }
}
