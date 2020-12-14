import 'dart:convert';

/// 离线推送信息实体
class OfflinePushInfoEntity {
  /// 通知栏标题
  String title;

  /// 通知栏内容
  String desc;

  /// 通知栏透传信息
  String ext;

  /// 离线推送声音设置（仅对 iOS 生效）。 当 sound = IOS_OFFLINE_PUSH_NO_SOUND，表示接收时不会播放声音。 如果要自定义 iOSSound，需要先把语音文件链接进 Xcode 工程，然后把语音文件名（带后缀）设置给 iOSSound。
  String iOSSound;

  /// 离线推送忽略 badge 计数（仅对 iOS 生效）， 如果设置为 true，在 iOS 接收端，这条消息不会使 APP 的应用图标未读计数增加。
  bool ignoreIOSBadge;

  /// 离线推送设置 OPPO 手机 8.0 系统及以上的渠道 ID。
  String androidOPPOChannelID;

  /// 获取是否关闭离线推送状态。
  bool disablePush;

  OfflinePushInfoEntity({
    this.title,
    this.desc,
    this.ext,
    this.iOSSound,
    this.ignoreIOSBadge,
    this.androidOPPOChannelID,
    this.disablePush,
  });

  OfflinePushInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    title = json["title"];
    desc = json["desc"];
    ext = json["ext"];
    iOSSound = json["iOSSound"];
    ignoreIOSBadge = json["ignoreIOSBadge"];
    androidOPPOChannelID = json["androidOPPOChannelID"];
    disablePush = json["disablePush"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) data['title'] = this.title;
    if (this.desc != null) data['desc'] = this.desc;
    if (this.ext != null) data['ext'] = this.ext;
    if (this.iOSSound != null) data['iOSSound'] = this.iOSSound;
    if (this.ignoreIOSBadge != null)
      data['ignoreIOSBadge'] = this.ignoreIOSBadge;
    if (this.androidOPPOChannelID != null)
      data['androidOPPOChannelID'] = this.androidOPPOChannelID;
    return data;
  }
}
