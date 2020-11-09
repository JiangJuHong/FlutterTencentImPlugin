package top.huic.tencent_im_plugin.util;

import com.alibaba.fastjson.JSON;
import com.tencent.imsdk.v2.V2TIMFriendApplication;
import com.tencent.imsdk.v2.V2TIMFriendApplicationResult;
import com.tencent.imsdk.v2.V2TIMGroupApplication;
import com.tencent.imsdk.v2.V2TIMGroupApplicationResult;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMValueCallback;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.entity.FindFriendApplicationEntity;
import top.huic.tencent_im_plugin.entity.FindGroupApplicationEntity;
import top.huic.tencent_im_plugin.entity.FindMessageEntity;

/**
 * 腾讯云IM工具类
 */
public class TencentImUtils {

    /**
     * 获得好友申请对象
     *
     * @param json json 字符串
     * @param call 回调对象
     */
    public static void getFriendApplicationByFindGroupApplicationEntity(String json, ValueCallBack<V2TIMFriendApplication> call) {
        getFriendApplicationByFindGroupApplicationEntity(JSON.parseObject(json, FindFriendApplicationEntity.class), call);
    }

    /**
     * 获得好友申请对象
     *
     * @param data 实体对象
     * @param call 回调对象
     */
    public static void getFriendApplicationByFindGroupApplicationEntity(final FindFriendApplicationEntity data, final ValueCallBack<V2TIMFriendApplication> call) {
        V2TIMManager.getFriendshipManager().getFriendApplicationList(new V2TIMValueCallback<V2TIMFriendApplicationResult>() {
            @Override
            public void onError(int i, String s) {
                call.onError(i, s);
            }

            @Override
            public void onSuccess(V2TIMFriendApplicationResult v2TIMFriendApplicationResult) {
                if (v2TIMFriendApplicationResult.getFriendApplicationList() != null) {
                    for (V2TIMFriendApplication item : v2TIMFriendApplicationResult.getFriendApplicationList()) {
                        if (item.getUserID().equals(data.getUserID()) && item.getType() == data.getType()) {
                            call.onSuccess(item);
                            return;
                        }
                    }
                }
                call.onSuccess(null);
            }
        });
    }

    /**
     * 获得群申请对象
     *
     * @param json json 字符串
     * @param call 回调对象
     */
    public static void getGroupApplicationByFindGroupApplicationEntity(String json, ValueCallBack<V2TIMGroupApplication> call) {
        getGroupApplicationByFindGroupApplicationEntity(JSON.parseObject(json, FindGroupApplicationEntity.class), call);
    }

    /**
     * 获得群申请对象
     *
     * @param data 实体对象
     * @param call 回调对象
     */
    public static void getGroupApplicationByFindGroupApplicationEntity(final FindGroupApplicationEntity data, final ValueCallBack<V2TIMGroupApplication> call) {
        V2TIMManager.getGroupManager().getGroupApplicationList(new V2TIMValueCallback<V2TIMGroupApplicationResult>() {
            @Override
            public void onError(int i, String s) {
                call.onError(i, s);
            }

            @Override
            public void onSuccess(V2TIMGroupApplicationResult v2TIMGroupApplicationResult) {
                if (v2TIMGroupApplicationResult.getGroupApplicationList() != null) {
                    for (V2TIMGroupApplication item : v2TIMGroupApplicationResult.getGroupApplicationList()) {
                        if (item.getGroupID().equals(data.getGroupID()) && item.getFromUser().equals(data.getFromUser())) {
                            call.onSuccess(item);
                            return;
                        }
                    }
                }
                call.onSuccess(null);
            }
        });
    }

    /**
     * 获得消息对象
     *
     * @param json json字符串
     * @param call 回调对象
     */
    public static void getMessageByFindMessageEntity(String json, ValueCallBack<V2TIMMessage> call) {
        getMessageByFindMessageEntity(JSON.parseObject(json, FindMessageEntity.class), call);
    }

    /**
     * 获得消息对象
     *
     * @param data 查找消息对象实体
     * @param call 回调对象
     */
    public static void getMessageByFindMessageEntity(FindMessageEntity data, final ValueCallBack<V2TIMMessage> call) {
        getMessageByFindMessageEntity(Collections.singletonList(data), new ValueCallBack<List<V2TIMMessage>>(null) {
            @Override
            public void onSuccess(List<V2TIMMessage> v2TIMMessages) {
                call.onSuccess(v2TIMMessages.size() >= 1 ? v2TIMMessages.get(0) : null);
            }

            @Override
            public void onError(int code, String desc) {
                call.onError(code, desc);
            }
        });
    }

    /**
     * 获得消息对象
     *
     * @param data 查找消息对象实体
     * @param call 回调对象
     */
    public static void getMessageByFindMessageEntity(List<FindMessageEntity> data, final ValueCallBack<List<V2TIMMessage>> call) {
        List<String> ids = new ArrayList<>();
        for (FindMessageEntity datum : data) {
            ids.add(datum.getMsgId());
        }
        V2TIMManager.getMessageManager().findMessages(ids, new V2TIMValueCallback<List<V2TIMMessage>>() {
            @Override
            public void onError(int i, String s) {
                call.onError(i, s);
            }

            @Override
            public void onSuccess(List<V2TIMMessage> v2TIMMessages) {
                call.onSuccess(v2TIMMessages);
            }
        });
    }
}