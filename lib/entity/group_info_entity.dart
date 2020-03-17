class GroupInfoEntity {
  String groupType;
  int maxMemberNum;
  String groupOwner;
  Map custom;
  String groupId;
  int resultCode;
  String groupNotification;
  int memberNum;
  String resultInfo;
  String faceUrl;
  String groupName;
  String addOption;
  int createTime;
  String groupIntroduction;
  bool silenceAll;
  int lastMsgTime;
  int onlineMemberNum;
  int lastInfoTime;

  GroupInfoEntity(
      {this.groupType,
      this.maxMemberNum,
      this.groupOwner,
      this.custom,
      this.groupId,
      this.resultCode,
      this.groupNotification,
      this.memberNum,
      this.resultInfo,
      this.faceUrl,
      this.groupName,
      this.addOption,
      this.createTime,
      this.groupIntroduction,
      this.silenceAll,
      this.lastMsgTime,
      this.onlineMemberNum,
      this.lastInfoTime});

  GroupInfoEntity.fromJson(Map<String, dynamic> json) {
    groupType = json['groupType'];
    maxMemberNum = json['maxMemberNum'];
    groupOwner = json['groupOwner'];
    custom = json['custom'];
    groupId = json['groupId'];
    resultCode = json['resultCode'];
    groupNotification = json['groupNotification'];
    memberNum = json['memberNum'];
    resultInfo = json['resultInfo'];
    faceUrl = json['faceUrl'];
    groupName = json['groupName'];
    addOption = json['addOption'];
    createTime = json['createTime'];
    groupIntroduction = json['groupIntroduction'];
    silenceAll = json['silenceAll'];
    lastMsgTime = json['lastMsgTime'];
    onlineMemberNum = json['onlineMemberNum'];
    lastInfoTime = json['lastInfoTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupType'] = this.groupType;
    data['maxMemberNum'] = this.maxMemberNum;
    data['groupOwner'] = this.groupOwner;
    if (this.custom != null) {
      data['custom'] = this.custom;
    }
    data['groupId'] = this.groupId;
    data['resultCode'] = this.resultCode;
    data['groupNotification'] = this.groupNotification;
    data['memberNum'] = this.memberNum;
    data['resultInfo'] = this.resultInfo;
    data['faceUrl'] = this.faceUrl;
    data['groupName'] = this.groupName;
    data['addOption'] = this.addOption;
    data['createTime'] = this.createTime;
    data['groupIntroduction'] = this.groupIntroduction;
    data['silenceAll'] = this.silenceAll;
    data['lastMsgTime'] = this.lastMsgTime;
    data['onlineMemberNum'] = this.onlineMemberNum;
    data['lastInfoTime'] = this.lastInfoTime;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupInfoEntity &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId;

  @override
  int get hashCode => groupId.hashCode;
}
