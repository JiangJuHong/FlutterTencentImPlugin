import 'dart:io';

import 'node_entity.dart';

class NodeCustomEntity extends NodeEntity {
  String data;

  NodeCustomEntity({this.data});

  NodeCustomEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    type = NodeEntity.fromJson(json).type;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['data'] = this.data;
    return data;
  }
}
