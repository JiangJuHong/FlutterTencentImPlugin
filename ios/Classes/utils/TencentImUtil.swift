import ImSDK

//  腾讯云工具类
//  Created by 蒋具宏 on 2020/2/10.
public class TencentImUtils {
    /**
     * 返回[错误返回闭包]，腾讯云IM通用格式
     */
    public static func returnErrorClosures(result: @escaping FlutterResult) -> TIMFail {
        return {
            (code: Int32, desc: Optional<String>) -> Void in
            result(
                    FlutterError(code: "\(code)", message: desc!, details: desc!)
            );
        };
    }

    /// 获得消息对象
    public static func getMessageByFindMessageEntity(json: String, succ: @escaping GetInfoSuc<V2TIMMessage?>, fail: @escaping V2TIMFail) {
        getMessageByFindMessageEntity(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json), succ: succ, fail: fail);
    }

    /// 获得消息对象
    public static func getMessageByFindMessageEntity(dict: [String: Any], succ: @escaping GetInfoSuc<V2TIMMessage?>, fail: @escaping V2TIMFail) {
        getMessageByFindMessageEntity(dict: [dict], succ: {
            (messages: [V2TIMMessage]?) in
            succ(messages!.count >= 1 ? messages![0] : nil);
        }, fail: fail);
    }

    /// 获得消息对象
    public static func getMessageByFindMessageEntity(dict: [[String: Any]], succ: @escaping GetInfoSuc<[V2TIMMessage]?>, fail: @escaping V2TIMFail) {
        var ids: [String] = [];
        for item in dict {
            let obj = FindMessageEntity.init(dict: item);
            ids.append(obj.msgId!);
        }

        V2TIMManager.sharedInstance()?.findMessages(ids, succ: {
            (messages: [V2TIMMessage]?) in
            succ(messages);
        }, fail: fail)
    }

    /// 获得群申请对象
    public static func getGroupApplicationByFindGroupApplicationEntity(json: String, succ: @escaping GetInfoSuc<V2TIMGroupApplication?>, fail: @escaping V2TIMFail) {
        getGroupApplicationByFindGroupApplicationEntity(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json), succ: succ, fail: fail);
    }

    /// 获得群申请对象
    public static func getGroupApplicationByFindGroupApplicationEntity(dict: [String: Any], succ: @escaping GetInfoSuc<V2TIMGroupApplication?>, fail: @escaping V2TIMFail) {
        let data = FindGroupApplicationEntity.init(dict: dict);
        V2TIMManager.sharedInstance().getGroupApplicationList({
            result in
            if result?.applicationList != nil {
                for item in result!.applicationList! {
                    let itemEntity = item as! V2TIMGroupApplication;
                    if itemEntity.groupID == data.groupID && itemEntity.fromUser == data.fromUser {
                        succ(itemEntity);
                        return;
                    }
                }
            }
            succ(nil);
        }, fail: fail)
    }

    /// 获得好友申请对象
    public static func getFriendApplicationByFindFriendApplicationEntity(json: String, succ: @escaping GetInfoSuc<V2TIMFriendApplication?>, fail: @escaping V2TIMFail) {
        getFriendApplicationByFindFriendApplicationEntity(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json), succ: succ, fail: fail);
    }

    /// 获得好友申请对象
    public static func getFriendApplicationByFindFriendApplicationEntity(dict: [String: Any], succ: @escaping GetInfoSuc<V2TIMFriendApplication?>, fail: @escaping V2TIMFail) {
        let data = FindFriendApplicationEntity.init(dict: dict);
        V2TIMManager.sharedInstance().getFriendApplicationList({
            result in
            if result?.applicationList != nil {
                for item in result!.applicationList! {
                    let itemEntity = item as! V2TIMFriendApplication;
                    if itemEntity.userID == data.userID && itemEntity.type.rawValue == data.type {
                        succ(itemEntity);
                        return;
                    }
                }
            }
            succ(nil);
        }, fail: fail)
    }
}

/**
 *  获取信息成功回调
 */
public typealias GetInfoSuc<T> = (_ array: T) -> Void;