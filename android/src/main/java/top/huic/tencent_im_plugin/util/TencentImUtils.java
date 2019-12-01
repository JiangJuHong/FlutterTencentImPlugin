package top.huic.tencent_im_plugin.util;

import android.os.Build;
import android.util.Log;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMValueCallBack;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import androidx.annotation.RequiresApi;
import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.interfaces.ValueCallBack;

/**
 * 腾讯云IM工具类
 */
public class TencentImUtils {
    /**
     * 根据Message对象获得所有节点
     *
     * @param message 消息对象
     * @return 所有节点对象
     */
    public static List<TIMElem> getArrrElement(TIMMessage message) {
        List<TIMElem> elems = new ArrayList<>();
        for (int i = 0; i < message.getElementCount(); i++) {
            elems.add(message.getElement(i));
        }
        return elems;
    }

    /**
     * 根据会话ID和会话类型获得会话对象
     * @param sessionId 会话ID
     * @param sessionTypeStr 会话类型字符串模式
     * @return 会话对象
     */
    public static TIMConversation getSession(String sessionId, String sessionTypeStr) {
        TIMConversationType sessionType = null;
        for (TIMConversationType value : TIMConversationType.values()) {
            if (sessionTypeStr.equals(value.name())) {
                sessionType = value;
                break;
            }
        }
        // 验证sessionType
        if (sessionType == null) {
            Log.w(TencentImPlugin.TAG, "init: Cannot find parameter `sessionType` or `sessionType` is null!");
            throw new RuntimeException("Cannot find parameter `sessionType` or `sessionType` is null!");
        }

        // 获得会话信息
        TIMConversation conversation = TIMManager.getInstance().getConversation(sessionType, sessionId);
        if (conversation == null) {
            throw new RuntimeException("Cannot find Conversation" + sessionId + "-" + sessionTypeStr);
        }
        return conversation;
    }

    /**
     * 获得完整的消息对象
     *
     * @param timMessages 消息列表
     * @param callBack    完成回调
     */
    public static void getMessageInfo(List<TIMMessage> timMessages, final ValueCallBack<List<MessageEntity>> callBack) {
        // 需要被获取用户信息的数据集
        final Map<String, List<MessageEntity>> userInfo = new HashMap<>();
        for (TIMMessage timMessage : timMessages) {
            List<MessageEntity> list = userInfo.get(timMessage.getSender());
            if (list == null) {
                list = new ArrayList<>();
            }
            list.add(new MessageEntity(timMessage));
            userInfo.put(timMessage.getSender(), list);
        }

        // 获取用户资料
        TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), false, new TIMValueCallBack<List<TIMUserProfile>>() {
            @Override
            public void onError(int code, String desc) {
                callBack.error(code, desc);
            }

            @RequiresApi(api = Build.VERSION_CODES.N)
            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                // 赋值用户信息并封装返回集合
                List<MessageEntity> messageEntities = new ArrayList<>();
                for (TIMUserProfile timUserProfile : timUserProfiles) {
                    List<MessageEntity> list = userInfo.get(timUserProfile.getIdentifier());
                    if (list != null) {
                        for (MessageEntity messageEntity : list) {
                            messageEntity.setUserInfo(timUserProfile);
                            messageEntities.add(messageEntity);
                        }
                    }
                }
                messageEntities.sort(new Comparator<MessageEntity>() {
                    @Override
                    public int compare(MessageEntity o1, MessageEntity o2) {
                        return o1.getTimestamp().compareTo(o2.getTimestamp());
                    }
                });
                callBack.success(messageEntities);
            }
        });
    }
}