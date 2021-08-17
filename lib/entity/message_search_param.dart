// To parse this JSON data, do
//
//     final messageSearchParam = messageSearchParamFromJson(jsonString);

import 'dart:convert';

/// 消息搜索参数对象
class MessageSearchParam {
  MessageSearchParam({
    this.conversationId,
    this.keyword,
    this.keywordMatchType,
    this.senderUserIds,
    this.messageTypes,
    this.searchTimePosition,
    this.searchTimePeriod,
    this.pageSize,
    this.pageIndex,
  });

  /// 指定会话ID
  final String? conversationId;

  /// 指定关键字，最多支持5个
  final List<String>? keyword;

  /// 关键字匹配类型
  final int? keywordMatchType;

  /// 发送人ID列表
  final List<String>? senderUserIds;

  /// 消息类型列表
  final List<int>? messageTypes;

  /// 搜索的起始时间点。默认为0即代表从现在开始搜索。UTC 时间戳，单位：秒
  final int? searchTimePosition;

  /// 从起始时间点开始的过去时间范围，单位秒。默认为0即代表不限制时间范围，传24x60x60代表过去一天。
  final int? searchTimePeriod;

  /// 每页结果数量：用于分页展示查找结果，如不希望分页可将其设置成 0，但如果结果太多，可能会带来性能问题。
  final int? pageSize;

  /// 分页的页号：用于分页展示查找结果，从零开始起步。 比如：您希望每页展示 10 条结果，请按照如下规则调用： - 首次调用：通过参数 pageSize = 10, pageIndex = 0 调用 searchLocalMessage，从结果回调中的 totalCount 可以获知总共有多少条结果。 - 计算页数：可以获知总页数：totalPage = (totalCount % pageSize == 0) ? (totalCount / pageSize) : (totalCount / pageSize + 1) 。 - 再次调用：可以通过指定参数 pageIndex （pageIndex < totalPage）返回后续页号的结果。
  final int? pageIndex;

  factory MessageSearchParam.fromRawJson(String str) => MessageSearchParam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageSearchParam.fromJson(Map<String, dynamic> json) => MessageSearchParam(
        conversationId: json["conversationID"] == null ? null : json["conversationID"],
        keyword: json["keyword"] == null ? null : List<String>.from(json["keyword"].map((x) => x)),
        keywordMatchType: json["keywordMatchType"] == null ? null : json["keywordMatchType"],
        senderUserIds: json["senderUserIds"] == null ? null : List<String>.from(json["senderUserIds"].map((x) => x)),
        messageTypes: json["messageTypes"] == null ? null : List<int>.from(json["messageTypes"].map((x) => x)),
        searchTimePosition: json["searchTimePosition"] == null ? null : json["searchTimePosition"],
        searchTimePeriod: json["searchTimePeriod"] == null ? null : json["searchTimePeriod"],
        pageSize: json["pageSize"] == null ? null : json["pageSize"],
        pageIndex: json["pageIndex"] == null ? null : json["pageIndex"],
      );

  Map<String, dynamic> toJson() => {
        "conversationID": conversationId == null ? null : conversationId,
        "keyword": keyword == null ? null : List<dynamic>.from(keyword!.map((x) => x)),
        "keywordMatchType": keywordMatchType == null ? null : keywordMatchType,
        "senderUserIds": senderUserIds == null ? null : List<dynamic>.from(senderUserIds!.map((x) => x)),
        "messageTypes": messageTypes == null ? null : List<dynamic>.from(messageTypes!.map((x) => x)),
        "searchTimePosition": searchTimePosition == null ? null : searchTimePosition,
        "searchTimePeriod": searchTimePeriod == null ? null : searchTimePeriod,
        "pageSize": pageSize == null ? null : pageSize,
        "pageIndex": pageIndex == null ? null : pageIndex,
      };
}
