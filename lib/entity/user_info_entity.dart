/// 用户信息实体
class UserInfoEntity {
  int birthday;
  String identifier;
  int role;
  int gender;
  int level;
  String nickName;
  int language;
  Map<String, dynamic> customInfo;
  String selfSignature;
  String allowType;
  String faceUrl;
  String location;

  // 该字段仅支持 Android 设备
  Map<String, dynamic> customInfoUint;

  UserInfoEntity({
    this.birthday,
    this.identifier,
    this.role,
    this.gender,
    this.level,
    this.nickName,
    this.language,
    this.customInfo,
    this.selfSignature,
    this.allowType,
    this.faceUrl,
    this.location,
    this.customInfoUint,
  });

  UserInfoEntity.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    identifier = json['identifier'];
    role = json['role'];
    gender = json['gender'];
    level = json['level'];
    nickName = json['nickName'];
    language = json['language'];
    customInfo = json['customInfo'];
    selfSignature = json['selfSignature'];
    allowType = json['allowType'];
    faceUrl = json['faceUrl'];
    location = json['location'];
    customInfoUint = json['customInfoUint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['identifier'] = this.identifier;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['level'] = this.level;
    data['nickName'] = this.nickName;
    data['language'] = this.language;
    if (this.customInfo != null) {
      data['customInfo'] = this.customInfo;
    }
    data['selfSignature'] = this.selfSignature;
    data['allowType'] = this.allowType;
    data['faceUrl'] = this.faceUrl;
    data['location'] = this.location;
    if (this.customInfoUint != null) {
      data['customInfoUint'] = this.customInfoUint;
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
