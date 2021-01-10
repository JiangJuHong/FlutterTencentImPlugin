import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 文件消息节点
class FileMessageNode extends MessageNode {
  /// 文件路径
  String filePath;

  /// 文件名
  String fileName;

  /// 文件ID
  String _uuid;

  /// 文件大小
  int _size;

  FileMessageNode({
    @required this.filePath,
    @required this.fileName,
  }) : super(MessageElemTypeEnum.File);

  FileMessageNode.fromJson(Map<String, dynamic> json) : super(MessageElemTypeEnum.File) {
    this.filePath = json["filePath"];
    this.fileName = json["fileName"];
    this._uuid = json["uuid"];
    this._size = json["size"];
  }

  /// 获得UUID
  String get uuid => _uuid;

  /// 获得文件大小
  int get size => _size;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["filePath"] = this.filePath;
    data["fileName"] = this.fileName;
    return data;
  }
}
