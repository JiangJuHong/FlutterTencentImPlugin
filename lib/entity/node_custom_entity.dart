import 'package:tencent_im_plugin/base64_util.dart';

import 'node_entity.dart';

class NodeCustomEntity extends NodeEntity {
  String ext;
  String data;
  String sound;
  String desc;

  NodeCustomEntity({this.ext, this.data, this.sound, this.desc});

  NodeCustomEntity.fromJson(Map<String, dynamic> json) {
    ext = json['ext'] != null ? Base64Util.base64Decode(json['ext']) : null;
    data = json['data'] != null ? Base64Util.base64Decode(json['data']) : null;
    sound =
        json['sound'] != null ? Base64Util.base64Decode(json['sound']) : null;
    type = NodeEntity.fromJson(json).type;
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['ext'] = this.ext;
    data['data'] = this.data;
    data['sound'] = this.sound;
    data['desc'] = this.desc;
    return data;
  }
}
