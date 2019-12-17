import 'package:tencent_im_plugin/entity/user_info_entity.dart';

class GroupMemberEntity {
  int role;
  int silenceSeconds;
  int joinTime;
  String nameCard;
  int tinyId;
  int msgSeq;
  int msgFlag;
  String user;
  UserInfoEntity userProfile;

  GroupMemberEntity({
    this.role,
    this.silenceSeconds,
    this.joinTime,
    this.nameCard,
    this.tinyId,
    this.msgSeq,
    this.msgFlag,
    this.user,
    this.userProfile,
  });

  GroupMemberEntity.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    silenceSeconds = json['silenceSeconds'];
    joinTime = json['joinTime'];
    nameCard = json['nameCard'];
    tinyId = json['tinyId'];
    msgSeq = json['msgSeq'];
    msgFlag = json['msgFlag'];
    user = json['user'];
    userProfile = json['userProfile'] == null
        ? null
        : UserInfoEntity.fromJson(json['userProfile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['silenceSeconds'] = this.silenceSeconds;
    data['joinTime'] = this.joinTime;
    data['nameCard'] = this.nameCard;
    data['tinyId'] = this.tinyId;
    data['msgSeq'] = this.msgSeq;
    data['msgFlag'] = this.msgFlag;
    data['user'] = this.user;
    data['userProfile'] =
        this.userProfile == null ? null : this.userProfile.toJson();
    return data;
  }
}
