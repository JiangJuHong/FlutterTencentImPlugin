import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/image_type_enum.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 图片消息节点
class ImageMessageNode extends MessageNode {
  /// 图片路径
  String path;

  /// 图片列表，根据类型分开
  Map<ImageTypeEnum, ImageEntity> _imageData;

  ImageMessageNode({
    @required this.path,
  }) : super(MessageElemTypeEnum.Image);

  ImageMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Image) {
    path = json['path'];
    if (json['imageData'] != null) {
      _imageData = Map();
      (json['imageData'] as List).forEach((v) {
        ImageEntity imageEntity = ImageEntity.fromJson(v);
        if (imageEntity != null) {
          _imageData[imageEntity.type] = imageEntity;
        }
      });
    }
  }

  /// 获得图片列表
  Map<ImageTypeEnum, ImageEntity> get imageData => _imageData;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    return data;
  }
}

/// 图片实体
class ImageEntity {
  /// 大小
  int size;

  /// 宽度
  int width;

  /// 类型
  ImageTypeEnum type;

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

  ImageEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    size = json['size'];
    width = json['width'];
    type = ImageTypeTool.getByInt(json["type"]);
    uuid = json['uUID'];
    url = json['url'];
    height = json['height'];
  }
}
