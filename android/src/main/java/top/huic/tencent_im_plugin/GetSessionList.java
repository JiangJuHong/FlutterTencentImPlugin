package top.huic.tencent_im_plugin;

import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupManager;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.SessionEntity;

/**
 * 获取会话列表类(此类仅用来获得用户会话列表)
 *
 * @author 蒋具宏
 */
public class GetSessionList {
    /**
     * 获取会话列表计数
     */
    private int index = 0;

    /**
     * 最大计数
     */
    private final static int MAX_INDEX = 2;


    /**
     * 追加计数，如果已到了末尾，则进行返回回调
     *
     * @param result 返回对象
     * @param data   数据对象
     */
    private void appendIndex(final MethodChannel.Result result, List<SessionEntity> data) {
        if (++index == MAX_INDEX) {
            index = 0;
            Log.i(TencentImPlugin.TAG, "追加: " + JSON.toJSONString(data));
            result.success(JSON.toJSONString(data));
        }
    }

    /**
     * 获取会话列表
     *
     * @param result Flutter返回对象
     */
    public void getConversationList(final MethodChannel.Result result) {
        final List<SessionEntity> resultData = new ArrayList<>();

        // 需要获取用户信息的列表
        final Map<String, SessionEntity> userInfo = new HashMap<>();

        // 需要获取的群信息列表
        final Map<String, SessionEntity> groupInfo = new HashMap<>();

        // 获取会话列表
        for (final TIMConversation timConversation : TIMManager.getInstance().getConversationList()) {
            // 封装会话信息
            SessionEntity entity = new SessionEntity();
            entity.setId(timConversation.getPeer());
            entity.setNickname(timConversation.getGroupName());
            entity.setType(timConversation.getType());
            entity.setUnreadMessageNum(timConversation.getUnreadMessageNum());

            // 获取资料
            if (timConversation.getType() == TIMConversationType.C2C) {
                userInfo.put(timConversation.getPeer(), entity);
            } else if (timConversation.getType() == TIMConversationType.Group) {
                groupInfo.put(timConversation.getPeer(), entity);
            }

            // 获取最后一条消息
            TIMMessage lastMsg = timConversation.getLastMsg();
            if (lastMsg != null) {
                // 封装消息信息
                MessageEntity messageEntity = new MessageEntity();
                messageEntity.setId(lastMsg.getMsgId());
                messageEntity.setTimestamp(lastMsg.timestamp());
                messageEntity.setElemList(TencentImUtils.getArrrElement(lastMsg));
                entity.setMessage(messageEntity);
            }
            resultData.add(entity);
        }

        // 获取群资料
        TIMGroupManager.getInstance().getGroupInfo(Arrays.asList(groupInfo.keySet().toArray(new String[0])), new TIMValueCallBack<List<TIMGroupDetailInfoResult>>() {
            @Override
            public void onError(int code, String desc) {
                Log.d(TencentImPlugin.TAG, "getGroupInfo failed, code: " + code + "|descr: " + desc);
                result.error(desc, String.valueOf(code), null);
            }

            @Override
            public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                for (TIMGroupDetailInfoResult timGroupDetailInfoResult : timGroupDetailInfoResults) {
                    SessionEntity sessionEntity = groupInfo.get(timGroupDetailInfoResult.getGroupId());
                    if (sessionEntity != null) {
                        sessionEntity.setNickname(timGroupDetailInfoResult.getGroupName());
                        sessionEntity.setFaceUrl(timGroupDetailInfoResult.getFaceUrl());
                    }
                }
                appendIndex(result, resultData);
            }
        });

        // 获取用户资料
        TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), false, new TIMValueCallBack<List<TIMUserProfile>>() {
            @Override
            public void onError(int code, String desc) {
                Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                result.error(desc, String.valueOf(code), null);
            }

            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                for (TIMUserProfile timUserProfile : timUserProfiles) {
                    SessionEntity sessionEntity = userInfo.get(timUserProfile.getIdentifier());
                    if (sessionEntity != null) {
                        sessionEntity.setNickname(timUserProfile.getNickName());
                        sessionEntity.setFaceUrl(timUserProfile.getFaceUrl());
                    }
                }
                appendIndex(result, resultData);
            }
        });
    }
}