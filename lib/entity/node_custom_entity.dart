import 'dart:io';

import 'package:tencent_im_plugin/base64_util.dart';

import 'node_entity.dart';

class NodeCustomEntity extends NodeEntity {
  String data;

  NodeCustomEntity({this.data});

  NodeCustomEntity.fromJson(Map<String, dynamic> json) {
    // 因为 fastJson 会将byte[]转换为base64，所以这里需要进行base64解码
    if(Platform.isAndroid){
      data = json['data'] != null ? Base64Util.base64Decode(json['data']) : null;
    }else{
      data = json['data'];
    }
    type = NodeEntity.fromJson(json).type;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['data'] = this.data;
    return data;
  }
}
