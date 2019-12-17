import 'package:tencent_im_plugin/entity/group_pendency_entity.dart';

class GroupPendencyPageEntity {
  int nextStartTimestamp;
  int reportedTimestamp;
  int unReadCount;
  List<GroupPendencyEntity> items;

  GroupPendencyPageEntity({
    this.nextStartTimestamp,
    this.reportedTimestamp,
    this.unReadCount,
    this.items,
  });

  GroupPendencyPageEntity.fromJson(Map<String, dynamic> json) {
    nextStartTimestamp = json['nextStartTimestamp'];
    reportedTimestamp = json['reportedTimestamp'];
    unReadCount = json['unReadCount'];
    if (json['items'] != null) {
      items = new List<GroupPendencyEntity>();
      (json['items'] as List).forEach((v) {
        items.add(new GroupPendencyEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextStartTimestamp'] = this.nextStartTimestamp;
    data['reportedTimestamp'] = this.reportedTimestamp;
    data['unReadCount'] = this.unReadCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
