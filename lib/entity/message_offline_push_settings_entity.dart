/// 离线推送实体
class MessageOfflinePushSettingsEntity {
  /// 描述信息
  final String desc;

  /// 标题信息
  final String title;

  MessageOfflinePushSettingsEntity({
    this.desc,
    this.title,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['title'] = this.title;
    return data;
  }
}
