import 'package:tencent_im_plugin/entity/node_entity.dart';

class NodeVideoEntity extends NodeEntity {
  String snapshotPath;
  String videoPath;
  NodeVideoSnapshotInfo snapshotInfo;
  NodeVideoVideoInfo videoInfo;
  int taskId;

  NodeVideoEntity(
      {this.snapshotPath,
      this.videoPath,
      this.snapshotInfo,
      this.videoInfo,
      this.taskId});

  NodeVideoEntity.fromJson(Map<String, dynamic> json) {
    snapshotPath = json['snapshotPath'];
    videoPath = json['videoPath'];
    snapshotInfo = json['snapshotInfo'] != null
        ? new NodeVideoSnapshotInfo.fromJson(json['snapshotInfo'])
        : null;
    videoInfo = json['videoInfo'] != null
        ? new NodeVideoVideoInfo.fromJson(json['videoInfo'])
        : null;
    type = NodeEntity.fromJson(json).type;
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['snapshotPath'] = this.snapshotPath;
    data['videoPath'] = this.videoPath;
    if (this.snapshotInfo != null) {
      data['snapshotInfo'] = this.snapshotInfo.toJson();
    }
    if (this.videoInfo != null) {
      data['videoInfo'] = this.videoInfo.toJson();
    }
    data['taskId'] = this.taskId;
    return data;
  }
}

class NodeVideoSnapshotInfo {
  int size;
  int width;
  String type;
  String uuid;
  int height;

  NodeVideoSnapshotInfo(
      {this.size, this.width, this.type, this.uuid, this.height});

  NodeVideoSnapshotInfo.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    width = json['width'];
    type = json['type'];
    uuid = json['uuid'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['width'] = this.width;
    data['type'] = this.type;
    data['uuid'] = this.uuid;
    data['height'] = this.height;
    return data;
  }
}

class NodeVideoVideoInfo {
  int duaration;
  int size;
  String type;
  String uuid;

  NodeVideoVideoInfo({this.duaration, this.size, this.type, this.uuid});

  NodeVideoVideoInfo.fromJson(Map<String, dynamic> json) {
    duaration = json['duaration'];
    size = json['size'];
    type = json['type'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duaration'] = this.duaration;
    data['size'] = this.size;
    data['type'] = this.type;
    data['uuid'] = this.uuid;
    return data;
  }
}
