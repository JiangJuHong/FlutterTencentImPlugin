import 'package:tencent_im_plugin/entity/node_text_entity.dart';

import 'node_image_entity.dart';

/// 节点最上层
class NodeEntity {
  // 节点类型
  NodeType type;

  NodeEntity({this.type});

  NodeEntity.fromJson(Map<String, dynamic> json) {
    for (var item in NodeType.values) {
      if (item.toString().replaceFirst("NodeType.", "") == json['type']) {
        type = item;
      }
    }
  }

  static getEntity(Map<String, dynamic> json) {
    if (json["type"] ==
        NodeType.Text.toString().replaceFirst("NodeType.", "")) {
      return NodeTextEntity.fromJson(json);
    } else if (json["type"] ==
        NodeType.Image.toString().replaceFirst("NodeType.", "")) {
      return NodeImageEntity.fromJson(json);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

/// 节点类型
enum NodeType {
  // 自定义
  Custom,
  // 表情
  Face,
  // 文件
  File,
  // 群系统消息
  GroupSystem,
  // 群组事件通知
  GroupTips,
  // 图片
  Image,
  // 非法值
  Invalid,
  // 地理位置信息
  Location,
  // 用户资料变更系统通知
  ProfileTips,
  // 关键链变更系统通知
  SNSTips,
  // 语音
  Sound,
  // 文本
  Text,
  // 微视频
  Video,
}
