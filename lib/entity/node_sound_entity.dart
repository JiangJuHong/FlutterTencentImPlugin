import 'package:tencent_im_plugin/entity/node_entity.dart';

class NodeSoundEntity extends NodeEntity{
	int duration;
	String path;
	int dataSize;
	String uuid;
	int taskId;

	NodeSoundEntity({this.duration, this.path, this.dataSize,  this.uuid, this.taskId});

	NodeSoundEntity.fromJson(Map<String, dynamic> json) {
		duration = json['duration'];
		path = json['path'];
		dataSize = json['dataSize'];
		type = NodeEntity.fromJson(json).type;
		uuid = json['uuid'];
		taskId = json['taskId'];
		type = super.type;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = super.toJson();
		data['duration'] = this.duration;
		data['path'] = this.path;
		data['dataSize'] = this.dataSize;
		data['type'] = this.type;
		data['uuid'] = this.uuid;
		data['taskId'] = this.taskId;
		return data;
	}
}
