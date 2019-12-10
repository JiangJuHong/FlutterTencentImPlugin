import 'pendency_entity.dart';

/// 未决分页实体
class PendencyPageEntity {
  /// 未读数量
  int unreadCnt;

  /// 数据列表
  List<PendencyEntity> items;

  /// 序列号
  int seq;

  /// 时间戳
  int timestamp;

  PendencyPageEntity({this.unreadCnt, this.items, this.seq, this.timestamp});

  PendencyPageEntity.fromJson(Map<String, dynamic> json) {
    unreadCnt = json['unreadCnt'];
    if (json['items'] != null) {
      items = new List<PendencyEntity>();
      (json['items'] as List).forEach((v) {
        items.add(new PendencyEntity.fromJson(v));
      });
    }
    seq = json['seq'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unreadCnt'] = this.unreadCnt;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['seq'] = this.seq;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
