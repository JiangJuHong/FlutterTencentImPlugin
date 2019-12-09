/// 群实体
class GroupEntity {
	// 未读消息数量
	int unReadMessageNum;
	// 群头像
	String faceUrl;
	// 群名称
	String groupName;
	// 群类型
	String groupType;
	// 角色
	int role;
	String recvOpt;
	// 加入时间
	int joinTime;
	// 群ID
	String groupId;
	// 当前群组是否设置了全员禁言
	bool silenceAll;

	GroupEntity({this.unReadMessageNum, this.faceUrl, this.groupName, this.groupType, this.role, this.recvOpt, this.joinTime, this.groupId, this.silenceAll});

	GroupEntity.fromJson(Map<String, dynamic> json) {
		unReadMessageNum = json['unReadMessageNum'];
		faceUrl = json['faceUrl'];
		groupName = json['groupName'];
		groupType = json['groupType'];
		role = json['role'];
		recvOpt = json['recvOpt'];
		joinTime = json['joinTime'];
		groupId = json['groupId'];
		silenceAll = json['silenceAll'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['unReadMessageNum'] = this.unReadMessageNum;
		data['faceUrl'] = this.faceUrl;
		data['groupName'] = this.groupName;
		data['groupType'] = this.groupType;
		data['role'] = this.role;
		data['recvOpt'] = this.recvOpt;
		data['joinTime'] = this.joinTime;
		data['groupId'] = this.groupId;
		data['silenceAll'] = this.silenceAll;
		return data;
	}
}
