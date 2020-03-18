package top.huic.tencent_im_plugin.util;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupManager;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;
import com.tencent.imsdk.ext.message.TIMMessageLocator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.SessionEntity;

/**
 * 腾讯云IM工具类
 */
public class TencentImUtils {

    /**
     * 获得会话信息
     *
     * @param callback      回调对象
     * @param conversations 原生会话列表
     */
    public static void getConversationInfo(final ValueCallBack<List<SessionEntity>> callback, final List<TIMConversation> conversations) {
        final List<SessionEntity> resultData = new ArrayList<>();

        if (conversations == null || conversations.size() == 0) {
            callback.onSuccess(resultData);
            return;
        }

        // 需要获取用户信息的列表
        final Map<String, SessionEntity> userInfo = new HashMap<>();

        // 需要获取的群信息列表
        final Map<String, SessionEntity> groupInfo = new HashMap<>();

        // 获取会话列表
        for (final TIMConversation timConversation : conversations) {
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
                // 加入到获取用户的队列
                userInfo.put(lastMsg.getSender(), entity);
                // 封装消息信息
                entity.setMessage(new MessageEntity(lastMsg));
            }
            resultData.add(entity);
        }

        // 初始化计数器
        final int maxIndex = (userInfo.size() != 0 ? 1 : 0) + (groupInfo.size() != 0 ? 1 : 0);
        if (maxIndex == 0) {
            callback.onSuccess(new ArrayList<SessionEntity>());
            return;
        }


        // 当前计数器
        final int[] currentIndex = {0};

        // 获取群资料
        if (groupInfo.size() != 0) {
            TIMGroupManager.getInstance().getGroupInfo(Arrays.asList(groupInfo.keySet().toArray(new String[0])), new ValueCallBack<List<TIMGroupDetailInfoResult>>(null) {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TencentImPlugin.TAG, "getGroupInfo failed, code: " + code + "|descr: " + desc);
                    callback.onError(code, desc);
                }

                @Override
                public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                    // 设置群资料
                    for (TIMGroupDetailInfoResult timGroupDetailInfoResult : timGroupDetailInfoResults) {
                        SessionEntity sessionEntity = groupInfo.get(timGroupDetailInfoResult.getGroupId());
                        if (sessionEntity != null) {
                            // 如果出现错误操作，则直接移除，且删除无效会话
                            if (timGroupDetailInfoResult.getResultCode() != 0) {
                                resultData.remove(sessionEntity);
                                TIMManager.getInstance().deleteConversation(TIMConversationType.Group, timGroupDetailInfoResult.getGroupId());
                            }

                            sessionEntity.setGroup(timGroupDetailInfoResult);
                            sessionEntity.setNickname(timGroupDetailInfoResult.getGroupName());
                            sessionEntity.setFaceUrl(timGroupDetailInfoResult.getFaceUrl());
                        }
                    }

                    // 回调成功
                    if (++currentIndex[0] >= maxIndex) {
                        callback.onSuccess(resultData);
                    }
                }
            });
        }

        // 获取用户资料
        if (userInfo.size() != 0) {
            TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), true, new TIMValueCallBack<List<TIMUserProfile>>() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                    callback.onError(code, desc);
                }

                @Override
                public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                    // 设置用户资料
                    for (TIMUserProfile timUserProfile : timUserProfiles) {
                        SessionEntity sessionEntity = userInfo.get(timUserProfile.getIdentifier());
                        // 会话用户ID
                        if (sessionEntity != null && timUserProfile.getIdentifier().equals(sessionEntity.getId())) {
                            sessionEntity.setUserProfile(timUserProfile);
                            sessionEntity.setNickname(timUserProfile.getNickName());
                            sessionEntity.setFaceUrl(timUserProfile.getFaceUrl());
                        }

                        // 最后一条消息用户ID
                        if (sessionEntity != null && sessionEntity.getMessage() != null && timUserProfile.getIdentifier().equals(sessionEntity.getMessage().getSender())) {
                            sessionEntity.getMessage().setUserInfo(timUserProfile);
                        }
                    }

                    // 回调成功
                    if (++currentIndex[0] >= maxIndex) {
                        callback.onSuccess(resultData);
                    }
                }
            });
        }
    }

    /**
     * 根据会话ID和会话类型获得会话对象
     *
     * @param sessionId      会话ID
     * @param sessionTypeStr 会话类型字符串模式
     * @return 会话对象
     */
    public static TIMConversation getSession(String sessionId, String sessionTypeStr) {
        TIMConversationType sessionType = TIMConversationType.valueOf(sessionTypeStr);

        // 获得会话信息
        TIMConversation conversation = TIMManager.getInstance().getConversation(sessionType, sessionId);
        if (conversation == null) {
            throw new RuntimeException("Cannot find Conversation" + sessionId + "-" + sessionTypeStr);
        }
        return conversation;
    }

    /**
     * 从结果中获得消息
     *
     * @param methodCall 方法调用对象
     * @param result     操作结果
     */
    public static void getTimMessage(MethodCall methodCall, final MethodChannel.Result result, final ValueCallBack<TIMMessage> onCallback) {
        // 获得参数
        String sessionId = CommonUtil.getParam(methodCall, result, "sessionId");
        String sessionTypeStr = CommonUtil.getParam(methodCall, result, "sessionType");
        long rand = Long.parseLong(CommonUtil.getParam(methodCall, result, "rand").toString());
        long seq = Long.parseLong(CommonUtil.getParam(methodCall, result, "seq").toString());
        Boolean self = methodCall.argument("self");
        Object timestamp = methodCall.argument("timestamp");

        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TIMMessageLocator locator = new TIMMessageLocator();
        locator.setRand(rand);
        locator.setSeq(seq);
        if (timestamp != null) {
            locator.setTimestamp(Long.parseLong(timestamp.toString()));
        }
        locator.setSelf(self == null ? true : self);

        // 获得消息
        conversation.findMessages(Collections.singletonList(locator), new ValueCallBack<List<TIMMessage>>(result) {
            @Override
            public void onSuccess(final List<TIMMessage> timMessages) {
                TIMMessage message = timMessages.get(0);
                onCallback.onSuccess(message);
            }
        });
    }

    /**
     * 获得消息实体
     *
     * @param methodCall 消息调用
     * @param result     操作结果
     * @param onCallback 回调
     */
    public static void getMessage(MethodCall methodCall, final MethodChannel.Result result, final ValueCallBack<MessageEntity> onCallback) {
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(final TIMMessage message) {
                TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                    @Override
                    public void onSuccess(List<MessageEntity> messageEntities) {
                        onCallback.onSuccess(messageEntities.get(0));
                    }
                });
            }
        });
    }

    /**
     * 获得完整的消息对象
     *
     * @param timMessages 消息列表
     * @param callBack    完成回调
     */
    public static void getMessageInfo(List<TIMMessage> timMessages, final ValueCallBack<List<MessageEntity>> callBack) {
        if (timMessages == null || timMessages.size() == 0) {
            callBack.onSuccess(new ArrayList<MessageEntity>());
            return;
        }

        // 返回结果
        final List<MessageEntity> resultData = new ArrayList<>(timMessages.size());
        for (TIMMessage timMessage : timMessages) {
            resultData.add(new MessageEntity(timMessage));
        }

        // 根据消息时间排序
        Collections.sort(resultData, new Comparator<MessageEntity>() {
            @Override
            public int compare(MessageEntity o1, MessageEntity o2) {
                return o1.getTimestamp().compareTo(o2.getTimestamp());
            }
        });

        // 获取用户资料(存储Key和下标，方便添加时快速查找)
        final Map<String, List<Integer>> userIds = new HashMap<>(resultData.size(), 1);
        for (int i = 0; i < resultData.size(); i++) {
            MessageEntity resultDatum = resultData.get(i);
            List<Integer> is = userIds.get(resultDatum.getSender());
            if (is == null) {
                is = new ArrayList<>();
            }
            is.add(i);
            userIds.put(resultDatum.getSender(), is);
        }
        TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userIds.keySet().toArray(new String[0])), true, new TIMValueCallBack<List<TIMUserProfile>>() {
            @Override
            public void onError(int code, String desc) {
                callBack.onError(code, desc);
            }

            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {

                // 数据复制
                for (TIMUserProfile timUserProfile : timUserProfiles) {
                    for (Integer integer : userIds.get(timUserProfile.getIdentifier())) {
                        resultData.get(integer).setUserInfo(timUserProfile);
                    }
                }
                callBack.onSuccess(resultData);
            }
        });
    }

    /**
     * 获得系统目录
     *
     * @param context 全局上下文
     * @return 获得结果
     */
    private static String getSystemFilePath(Context context) {
        String cachePath;
        if (Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState())
                || !Environment.isExternalStorageRemovable()) {
            cachePath = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES).getAbsolutePath();
        } else {
            cachePath = context.getFilesDir().getAbsolutePath();
        }
        return cachePath;
    }
}