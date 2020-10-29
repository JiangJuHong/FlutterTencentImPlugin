package top.huic.tencent_im_plugin;

import android.content.Context;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.tencent.imsdk.v2.V2TIMConversation;
import com.tencent.imsdk.v2.V2TIMConversationResult;
import com.tencent.imsdk.v2.V2TIMCreateGroupMemberInfo;
import com.tencent.imsdk.v2.V2TIMGroupApplicationResult;
import com.tencent.imsdk.v2.V2TIMGroupInfo;
import com.tencent.imsdk.v2.V2TIMGroupInfoResult;
import com.tencent.imsdk.v2.V2TIMGroupMemberFullInfo;
import com.tencent.imsdk.v2.V2TIMGroupMemberInfoResult;
import com.tencent.imsdk.v2.V2TIMGroupMemberOperationResult;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMOfflinePushInfo;
import com.tencent.imsdk.v2.V2TIMSDKConfig;
import com.tencent.imsdk.v2.V2TIMSendCallback;
import com.tencent.imsdk.v2.V2TIMSignalingInfo;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import top.huic.tencent_im_plugin.entity.FindMessageEntity;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.listener.CustomAdvancedMsgListener;
import top.huic.tencent_im_plugin.listener.CustomConversationListener;
import top.huic.tencent_im_plugin.listener.CustomFriendshipListener;
import top.huic.tencent_im_plugin.listener.CustomGroupListener;
import top.huic.tencent_im_plugin.listener.CustomSDKListener;
import top.huic.tencent_im_plugin.listener.CustomSignalingListener;
import top.huic.tencent_im_plugin.message.AbstractMessageNode;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;
import top.huic.tencent_im_plugin.util.CommonUtil;
import top.huic.tencent_im_plugin.util.JsonUtil;
import top.huic.tencent_im_plugin.util.TencentImUtils;

/**
 * TencentImPlugin
 */
public class TencentImPlugin implements FlutterPlugin, MethodCallHandler {

    /**
     * 日志签名
     */
    public static String TAG = "TencentImPlugin";

    /**
     * 全局上下文
     */
    public static Context context;

    /**
     * 与Flutter的通信管道
     */
    private static MethodChannel channel;

    public TencentImPlugin() {
    }

    private TencentImPlugin(Context context, MethodChannel channel) {
        TencentImPlugin.context = context;
        TencentImPlugin.channel = channel;
        JSON.DEFAULT_GENERATE_FEATURE |= SerializerFeature.DisableCircularReferenceDetect.mask;
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tencent_im_plugin");
        channel.setMethodCallHandler(new TencentImPlugin(flutterPluginBinding.getApplicationContext(), channel));
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "tencent_im_plugin");
        channel.setMethodCallHandler(new TencentImPlugin(registrar.context(), channel));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        try {
            Method method = this.getClass().getDeclaredMethod(call.method, MethodCall.class, Result.class);
            method.setAccessible(true);
            method.invoke(this, call, result);
        } catch (NoSuchMethodException e) {
            result.notImplemented();
        } catch (IllegalAccessException e) {
            result.notImplemented();
        } catch (InvocationTargetException ignored) {
        }
    }


    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
    }

    /**
     * 腾讯云Im初始化事件
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void initSDK(MethodCall methodCall, Result result) {
        String appid = CommonUtil.getParam(methodCall, result, "appid");
        Integer logPrintLevel = methodCall.argument("logPrintLevel");

        // 初始化 SDK
        V2TIMSDKConfig sdkConfig = new V2TIMSDKConfig();
        if (logPrintLevel != null) {
            sdkConfig.setLogLevel(logPrintLevel);
        }
        V2TIMManager.getInstance().initSDK(context, Integer.parseInt(appid), sdkConfig, new CustomSDKListener());

        // 绑定消息监听
        V2TIMManager.getMessageManager().addAdvancedMsgListener(new CustomAdvancedMsgListener());

        // 绑定会话监听器
        V2TIMManager.getConversationManager().setConversationListener(new CustomConversationListener());

        // 绑定群监听器
        V2TIMManager.getInstance().setGroupListener(new CustomGroupListener());

        // 绑定关系链监听器
        V2TIMManager.getFriendshipManager().setFriendListener(new CustomFriendshipListener());

        // 绑定信令监听器
        V2TIMManager.getSignalingManager().addSignalingListener(new CustomSignalingListener());

        result.success(null);
    }


    /**
     * 反初始化
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void unInitSDK(MethodCall methodCall, Result result) {
        V2TIMManager.getInstance().unInitSDK();
        result.success(null);
    }

    /**
     * 腾讯云 IM 登录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void login(MethodCall methodCall, final Result result) {
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        String userSig = CommonUtil.getParam(methodCall, result, "userSig");

        // 登录操作
        V2TIMManager.getInstance().login(userID, userSig, new VoidCallBack(result));
    }

    /**
     * 腾讯云 IM 退出登录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void logout(MethodCall methodCall, final Result result) {
        V2TIMManager.getInstance().logout(new VoidCallBack(result));
    }

    /**
     * 获得登录状态
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLoginStatus(MethodCall methodCall, final Result result) {
        result.success(V2TIMManager.getInstance().getLoginStatus());
    }

    /**
     * 腾讯云 获得当前登录用户
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLoginUser(MethodCall methodCall, final Result result) {
        result.success(V2TIMManager.getInstance().getLoginUser());
    }

    /**
     * 邀请某个人
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void invite(MethodCall methodCall, final Result result) {
        String invitee = CommonUtil.getParam(methodCall, result, "invitee");
        String data = CommonUtil.getParam(methodCall, result, "data");
        Boolean onlineUserOnly = CommonUtil.getParam(methodCall, result, "onlineUserOnly");
        String offlinePushInfoStr = CommonUtil.getParam(methodCall, result, "offlinePushInfo");
        int timeout = CommonUtil.getParam(methodCall, result, "timeout");

        // 将离线推送配置转换为JSON对象以及离线推送对象
        JSONObject jsonObject = JSON.parseObject(offlinePushInfoStr);
        V2TIMOfflinePushInfo offlinePushInfo = JSON.parseObject(offlinePushInfoStr, V2TIMOfflinePushInfo.class);
        if (jsonObject.get("disablePush") != null) {
            offlinePushInfo.disablePush(jsonObject.getBoolean("disablePush"));
        }

        // 发送邀请，并同步返回结果
        result.success(V2TIMManager.getSignalingManager().invite(invitee, data, onlineUserOnly, offlinePushInfo, timeout, new VoidCallBack(null)));
    }

    /**
     * 邀请群内的某些人
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void inviteInGroup(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        List<String> inviteeList = Arrays.asList(CommonUtil.getParam(methodCall, result, "inviteeList").toString().split(","));
        String data = CommonUtil.getParam(methodCall, result, "data");
        Boolean onlineUserOnly = CommonUtil.getParam(methodCall, result, "onlineUserOnly");
        int timeout = CommonUtil.getParam(methodCall, result, "timeout");

        // 发送邀请，并同步返回结果
        result.success(V2TIMManager.getSignalingManager().inviteInGroup(groupID, inviteeList, data, onlineUserOnly, timeout, new VoidCallBack(null)));
    }

    /**
     * 邀请方取消邀请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void cancel(MethodCall methodCall, final Result result) {
        String inviteID = CommonUtil.getParam(methodCall, result, "inviteID");
        String data = CommonUtil.getParam(methodCall, result, "data");
        V2TIMManager.getSignalingManager().cancel(inviteID, data, new VoidCallBack(result));
    }

    /**
     * 接收方接收邀请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void accept(MethodCall methodCall, final Result result) {
        String inviteID = CommonUtil.getParam(methodCall, result, "inviteID");
        String data = CommonUtil.getParam(methodCall, result, "data");
        V2TIMManager.getSignalingManager().accept(inviteID, data, new VoidCallBack(result));
    }

    /**
     * 接收方拒绝邀请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void reject(MethodCall methodCall, final Result result) {
        String inviteID = CommonUtil.getParam(methodCall, result, "inviteID");
        String data = CommonUtil.getParam(methodCall, result, "data");
        V2TIMManager.getSignalingManager().reject(inviteID, data, new VoidCallBack(result));
    }

    /**
     * 获得信令信息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getSignalingInfo(MethodCall methodCall, final Result result) {
        String message = CommonUtil.getParam(methodCall, result, "message");
        result.success(JsonUtil.toJSONString(V2TIMManager.getSignalingManager().getSignalingInfo(TencentImUtils.getMessageByFindMessageEntity(message))));
    }

    /**
     * 添加邀请信令（可以用于群离线推送消息触发的邀请信令）
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void addInvitedSignaling(MethodCall methodCall, final Result result) {
        String info = CommonUtil.getParam(methodCall, result, "info");
        V2TIMManager.getSignalingManager().addInvitedSignaling(JSON.parseObject(info, V2TIMSignalingInfo.class), new VoidCallBack(result));
    }

    /**
     * 发送消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendMessage(MethodCall methodCall, final Result result) {
        String receiver = methodCall.argument("receiver");
        String groupID = methodCall.argument("groupID");
        String nodeStr = CommonUtil.getParam(methodCall, result, "node");
        Map node = JSON.parseObject(nodeStr, Map.class);
        boolean ol = CommonUtil.getParam(methodCall, result, "ol");
        Integer localCustomInt = methodCall.argument("localCustomInt");
        String localCustomStr = methodCall.argument("localCustomStr");
        Integer priority = CommonUtil.getParam(methodCall, result, "priority");
        String offlinePushInfo = methodCall.argument("offlinePushInfo");

        // 设置节点信息获得V2TIMMessage对象
        AbstractMessageNode messageNode = MessageNodeType.getMessageNodeTypeByV2TIMConstant(Integer.valueOf(node.get("nodeType").toString())).getMessageNodeInterface();
        AbstractMessageEntity messageEntity = (AbstractMessageEntity) JSON.parseObject(nodeStr, messageNode.getEntityClass());
        V2TIMMessage message = messageNode.getV2TIMMessage(messageEntity);
        if (localCustomInt != null) {
            message.setLocalCustomInt(localCustomInt);
        }
        if (localCustomStr != null) {
            message.setLocalCustomData(localCustomStr);
        }

        // 发送消息
        V2TIMManager.getMessageManager().sendMessage(message, receiver, groupID, priority, ol, offlinePushInfo == null ? null : JSON.parseObject(offlinePushInfo, V2TIMOfflinePushInfo.class), new V2TIMSendCallback<V2TIMMessage>() {
            @Override
            public void onError(int i, String s) {
                result.error(String.valueOf(i), s, s);
            }

            @Override
            public void onSuccess(V2TIMMessage o) {
                result.success(null);
            }

            @Override
            public void onProgress(int i) {
                System.out.println("2");
            }
        });
    }

    /**
     * 撤回消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void revokeMessage(MethodCall methodCall, final Result result) {
        String message = CommonUtil.getParam(methodCall, result, "message");
        V2TIMManager.getMessageManager().revokeMessage(TencentImUtils.getMessageByFindMessageEntity(message), new VoidCallBack(result));
    }

    /**
     * 获得单聊历史记录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getC2CHistoryMessageList(MethodCall methodCall, final Result result) {
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        int count = CommonUtil.getParam(methodCall, result, "count");
        String lastMsgStr = methodCall.argument("lastMsg");

        V2TIMManager.getMessageManager().getC2CHistoryMessageList(userID, count, lastMsgStr == null ? null : TencentImUtils.getMessageByFindMessageEntity(lastMsgStr), new ValueCallBack<List<V2TIMMessage>>(result) {
            @Override
            public void onSuccess(List<V2TIMMessage> v2TIMMessages) {
                List<MessageEntity> resultData = new ArrayList<>(v2TIMMessages.size());
                for (V2TIMMessage v2TIMMessage : v2TIMMessages) {
                    resultData.add(new MessageEntity(v2TIMMessage));
                }
                result.success(JsonUtil.toJSONString(resultData));
            }
        });
    }

    /**
     * 获得群聊历史记录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupHistoryMessageList(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        int count = CommonUtil.getParam(methodCall, result, "count");
        String lastMsgStr = methodCall.argument("lastMsg");

        V2TIMManager.getMessageManager().getGroupHistoryMessageList(groupID, count, lastMsgStr == null ? null : TencentImUtils.getMessageByFindMessageEntity(lastMsgStr), new ValueCallBack<List<V2TIMMessage>>(result) {
            @Override
            public void onSuccess(List<V2TIMMessage> v2TIMMessages) {
                List<MessageEntity> resultData = new ArrayList<>(v2TIMMessages.size());
                for (V2TIMMessage v2TIMMessage : v2TIMMessages) {
                    resultData.add(new MessageEntity(v2TIMMessage));
                }
                result.success(JsonUtil.toJSONString(resultData));
            }
        });
    }

    /**
     * 设置单聊已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void markC2CMessageAsRead(MethodCall methodCall, final Result result) {
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        V2TIMManager.getMessageManager().markC2CMessageAsRead(userID, new VoidCallBack(result));
    }

    /**
     * 设置群聊已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void markGroupMessageAsRead(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        V2TIMManager.getMessageManager().markGroupMessageAsRead(groupID, new VoidCallBack(result));
    }

    /**
     * 删除本地消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteMessageFromLocalStorage(MethodCall methodCall, final Result result) {
        String message = CommonUtil.getParam(methodCall, result, "message");
        V2TIMManager.getMessageManager().deleteMessageFromLocalStorage(TencentImUtils.getMessageByFindMessageEntity(message), new VoidCallBack(result));
    }

    /**
     * 删除本地及漫游消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteMessages(MethodCall methodCall, final Result result) {
        String message = CommonUtil.getParam(methodCall, result, "message");

        List<FindMessageEntity> queryMessage = JSON.parseArray(message, FindMessageEntity.class);
        List<V2TIMMessage> messages = new ArrayList<>(queryMessage.size());
        for (FindMessageEntity findMessageEntity : queryMessage) {
            messages.add(TencentImUtils.getMessageByFindMessageEntity(findMessageEntity));
        }
        V2TIMManager.getMessageManager().deleteMessages(messages, new VoidCallBack(result));
    }

    /**
     * 向群组消息列表中添加一条消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void insertGroupMessageToLocalStorage(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String sender = CommonUtil.getParam(methodCall, result, "sender");
        String nodeStr = CommonUtil.getParam(methodCall, result, "node");
        Map node = JSON.parseObject(nodeStr, Map.class);

        // 获得消息对象
        AbstractMessageNode messageNode = MessageNodeType.getMessageNodeTypeByV2TIMConstant(Integer.valueOf(node.get("nodeType").toString())).getMessageNodeInterface();
        AbstractMessageEntity messageEntity = (AbstractMessageEntity) JSON.parseObject(nodeStr, messageNode.getEntityClass());

        // 添加消息
        V2TIMManager.getMessageManager().insertGroupMessageToLocalStorage(messageNode.getV2TIMMessage(messageEntity), groupID, sender, new ValueCallBack<V2TIMMessage>(result) {
            @Override
            public void onSuccess(V2TIMMessage message) {
                result.success(null);
            }
        });
    }

    /**
     * 创建群
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void createGroup(MethodCall methodCall, final Result result) {
        String info = CommonUtil.getParam(methodCall, result, "info");
        String memberListStr = methodCall.argument("memberList");
        V2TIMManager.getGroupManager().createGroup(JSON.parseObject(info, V2TIMGroupInfo.class), memberListStr == null ? null : JSON.parseArray(memberListStr, V2TIMCreateGroupMemberInfo.class), new ValueCallBack<String>(result));
    }

    /**
     * 加入群
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void joinGroup(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String message = CommonUtil.getParam(methodCall, result, "message");
        V2TIMManager.getInstance().joinGroup(groupID, message, new VoidCallBack(result));
    }

    /**
     * 退出群
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void quitGroup(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        V2TIMManager.getInstance().quitGroup(groupID, new VoidCallBack(result));
    }

    /**
     * 解散群
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void dismissGroup(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        V2TIMManager.getInstance().dismissGroup(groupID, new VoidCallBack(result));
    }

    /**
     * 获得已加入的群列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getJoinedGroupList(MethodCall methodCall, final Result result) {
        V2TIMManager.getGroupManager().getJoinedGroupList(new ValueCallBack<List<V2TIMGroupInfo>>(result));
    }

    /**
     * 拉取群资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupsInfo(MethodCall methodCall, final Result result) {
        String groupIDList = CommonUtil.getParam(methodCall, result, "groupID");
        V2TIMManager.getGroupManager().getGroupsInfo(Arrays.asList(groupIDList.split(",")), new ValueCallBack<List<V2TIMGroupInfoResult>>(result));
    }

    /**
     * 修改群资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setGroupInfo(MethodCall methodCall, final Result result) {
        String info = CommonUtil.getParam(methodCall, result, "info");
        V2TIMManager.getGroupManager().setGroupInfo(JSON.parseObject(info, V2TIMGroupInfo.class), new VoidCallBack(result));
    }

    /**
     * 修改群消息接收选项
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setReceiveMessageOpt(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        int opt = CommonUtil.getParam(methodCall, result, "opt");
        V2TIMManager.getGroupManager().setReceiveMessageOpt(groupID, opt, new VoidCallBack(result));
    }

    /**
     * 初始化群属性，会清空原有的群属性列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void initGroupAttributes(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String attributes = CommonUtil.getParam(methodCall, result, "attributes");
        V2TIMManager.getGroupManager().initGroupAttributes(groupID, JSON.parseObject(attributes, HashMap.class), new VoidCallBack(result));
    }

    /**
     * 设置群属性。已有该群属性则更新其 value 值，没有该群属性则添加该属性。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setGroupAttributes(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String attributes = CommonUtil.getParam(methodCall, result, "attributes");
        V2TIMManager.getGroupManager().setGroupAttributes(groupID, JSON.parseObject(attributes, HashMap.class), new VoidCallBack(result));
    }

    /**
     * 删除指定群属性，keys 传 null 则清空所有群属性。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteGroupAttributes(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String keys = methodCall.argument("keys");
        V2TIMManager.getGroupManager().deleteGroupAttributes(groupID, keys == null ? null : Arrays.asList(keys.split(",")), new VoidCallBack(result));
    }

    /**
     * 获取指定群属性，keys 传 null 则获取所有群属性。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupAttributes(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String keys = methodCall.argument("keys");
        V2TIMManager.getGroupManager().getGroupAttributes(groupID, keys == null ? null : Arrays.asList(keys.split(",")), new ValueCallBack<Map<String, String>>(result));
    }

    /**
     * 获取群成员列表。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupOnlineMemberCount(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        int filter = CommonUtil.getParam(methodCall, result, "filter");
        int nextSeq = CommonUtil.getParam(methodCall, result, "nextSeq");
        V2TIMManager.getGroupManager().getGroupMemberList(groupID, filter, nextSeq, new ValueCallBack<V2TIMGroupMemberInfoResult>(result));
    }

    /**
     * 获取指定的群成员资料。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupMembersInfo(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String memberList = CommonUtil.getParam(methodCall, result, "memberList");
        V2TIMManager.getGroupManager().getGroupMembersInfo(groupID, Arrays.asList(memberList.split(",")), new ValueCallBack<List<V2TIMGroupMemberFullInfo>>(result));
    }

    /**
     * 修改指定的群成员资料。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setGroupMemberInfo(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String info = CommonUtil.getParam(methodCall, result, "info");
        V2TIMManager.getGroupManager().setGroupMemberInfo(groupID, JSON.parseObject(info, V2TIMGroupMemberFullInfo.class), new VoidCallBack(result));
    }

    /**
     * 禁言。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void muteGroupMember(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        int seconds = CommonUtil.getParam(methodCall, result, "seconds");
        V2TIMManager.getGroupManager().muteGroupMember(groupID, userID, seconds, new VoidCallBack(result));
    }


    /**
     * 邀请他人入群。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void inviteUserToGroup(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String userList = CommonUtil.getParam(methodCall, result, "userList");
        V2TIMManager.getGroupManager().inviteUserToGroup(groupID, Arrays.asList(userList.split(",")), new ValueCallBack<List<V2TIMGroupMemberOperationResult>>(result));
    }

    /**
     * 踢人。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void kickGroupMember(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String memberList = CommonUtil.getParam(methodCall, result, "memberList");
        String reason = CommonUtil.getParam(methodCall, result, "reason");
        V2TIMManager.getGroupManager().kickGroupMember(groupID, Arrays.asList(memberList.split(",")), reason, new ValueCallBack<List<V2TIMGroupMemberOperationResult>>(result));
    }

    /**
     * 切换群成员角色。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setGroupMemberRole(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        int role = CommonUtil.getParam(methodCall, result, "role");
        V2TIMManager.getGroupManager().setGroupMemberRole(groupID, userID, role, new VoidCallBack(result));
    }

    /**
     * 转让群主。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void transferGroupOwner(MethodCall methodCall, final Result result) {
        String groupID = CommonUtil.getParam(methodCall, result, "groupID");
        String userID = CommonUtil.getParam(methodCall, result, "userID");
        V2TIMManager.getGroupManager().transferGroupOwner(groupID, userID, new VoidCallBack(result));
    }

    /**
     * 获得群申请列表。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupApplicationList(MethodCall methodCall, final Result result) {
        V2TIMManager.getGroupManager().getGroupApplicationList(new ValueCallBack<V2TIMGroupApplicationResult>(result));
    }


    /**
     * 同意某一条加群申请。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void acceptGroupApplication(MethodCall methodCall, final Result result) {
        String application = CommonUtil.getParam(methodCall, result, "application");
        String reason = CommonUtil.getParam(methodCall, result, "reason");
        V2TIMManager.getGroupManager().acceptGroupApplication(TencentImUtils.getGroupApplicationByFindGroupApplicationEntity(application), reason, new VoidCallBack(result));
    }


    /**
     * 拒绝某一条加群申请。
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void refuseGroupApplication(MethodCall methodCall, final Result result) {
        String application = CommonUtil.getParam(methodCall, result, "application");
        String reason = CommonUtil.getParam(methodCall, result, "reason");
        V2TIMManager.getGroupManager().refuseGroupApplication(TencentImUtils.getGroupApplicationByFindGroupApplicationEntity(application), reason, new VoidCallBack(result));
    }

    /**
     * 标记申请列表为已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setGroupApplicationRead(MethodCall methodCall, final Result result) {
        V2TIMManager.getGroupManager().setGroupApplicationRead(new VoidCallBack(result));
    }

    /**
     * 获得会话列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getConversationList(MethodCall methodCall, final Result result) {
        int nextSeq = CommonUtil.getParam(methodCall, result, "nextSeq");
        int count = CommonUtil.getParam(methodCall, result, "count");
        V2TIMManager.getConversationManager().getConversationList(nextSeq, count, new ValueCallBack<V2TIMConversationResult>(result));
    }

    /**
     * 获得指定会话
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getConversation(MethodCall methodCall, final Result result) {
        String conversationID = CommonUtil.getParam(methodCall, result, "conversationID");
        V2TIMManager.getConversationManager().getConversation(conversationID, new ValueCallBack<V2TIMConversation>(result));
    }

    /**
     * 删除会话
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteConversation(MethodCall methodCall, final Result result) {
        String conversationID = CommonUtil.getParam(methodCall, result, "conversationID");
        V2TIMManager.getConversationManager().deleteConversation(conversationID, new VoidCallBack(result));
    }

    /**
     * 设置会话草稿
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setConversationDraft(MethodCall methodCall, final Result result) {
        String conversationID = CommonUtil.getParam(methodCall, result, "conversationID");
        String draftText = methodCall.argument("draftText");
        V2TIMManager.getConversationManager().setConversationDraft(conversationID, draftText, new VoidCallBack(result));
    }


//    /**
//     * 腾讯云 获得当前登录用户会话列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getConversationList(MethodCall methodCall, final Result result) {
//        TencentImUtils.getConversationInfo(new ValueCallBack<List<SessionEntity>>(result), V2TIMManager.getInstance().getConversationList());
//    }
//
//    /**
//     * 腾讯云 根据ID获得会话
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getConversation(MethodCall methodCall, final Result result) {
//        // 会话ID
//        String sessionId = CommonUtil.getParam(methodCall, result, "sessionId");
//        // 会话类型
//        String sessionTypeStr = CommonUtil.getParam(methodCall, result, "sessionType");
//        // 获得会话信息
//        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
//        TencentImUtils.getConversationInfo(new ValueCallBack<List<SessionEntity>>(result) {
//            @Override
//            public void onSuccess(List<SessionEntity> sessionEntities) {
//                if (sessionEntities.size() > 0)
//                    result.success(JsonUtil.toJSONString(sessionEntities.get(0)));
//                else
//                    result.success(null);
//            }
//        }, Collections.singletonList(conversation));
//    }
//
//    /**
//     * 腾讯云 获得群信息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getGroupInfo(MethodCall methodCall, final Result result) {
//        // 群ID
//        String id = CommonUtil.getParam(methodCall, result, "id");
//        TIMGroupDetailInfo groupDetailInfo = TIMGroupManager.getInstance().queryGroupInfo(id);
//        if (groupDetailInfo == null) {
//            TIMGroupManager.getInstance().getGroupInfo(Collections.singletonList(id), new ValueCallBack<List<TIMGroupDetailInfoResult>>(result) {
//                @Override
//                public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
//                    if (timGroupDetailInfoResults != null && timGroupDetailInfoResults.size() >= 1) {
//                        result.success(JsonUtil.toJSONString(timGroupDetailInfoResults.get(0)));
//                    } else {
//                        result.success(null);
//                    }
//                }
//            });
//        } else {
//            result.success(JsonUtil.toJSONString(groupDetailInfo));
//        }
//    }
//
//    /**
//     * 腾讯云 获得用户信息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getUserInfo(MethodCall methodCall, final Result result) {
//        // 用户ID
//        String id = CommonUtil.getParam(methodCall, result, "id");
//        boolean forceUpdate = CommonUtil.getParam(methodCall, result, "forceUpdate");
//        TIMFriendshipManager.getInstance().getUsersProfile(Collections.singletonList(id), forceUpdate, new ValueCallBack<List<TIMUserProfile>>(result) {
//            @Override
//            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
//                if (timUserProfiles != null && timUserProfiles.size() >= 1) {
//                    result.success(JsonUtil.toJSONString(timUserProfiles.get(0)));
//                } else {
//                    result.success(null);
//                }
//            }
//        });
//    }
//    /**
//     * 获得消息列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     * @param local      是否是获取本地消息
//     */
//    private void getMessages(MethodCall methodCall, final Result result, final boolean local) {
//        // 会话IDgetMessage
//        String sessionId = CommonUtil.getParam(methodCall, result, "sessionId");
//        // 会话类型
//        String sessionTypeStr = CommonUtil.getParam(methodCall, result, "sessionType");
//        // 消息数量
//        final Integer number = CommonUtil.getParam(methodCall, result, "number");
//        // 获得会话信息
//        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
//
//        TencentImUtils.getTimMessage(methodCall, result, "lastMessage", new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                // 获得聊天记录
//                if (local) {
//                    conversation.getLocalMessage(number, message, new ValueCallBack<List<TIMMessage>>(result) {
//                        @Override
//                        public void onSuccess(List<TIMMessage> timMessages) {
//                            if (timMessages == null || timMessages.size() == 0) {
//                                result.success(JsonUtil.toJSONString(new ArrayList<>()));
//                                return;
//                            }
//                            TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>(result));
//                        }
//                    });
//                } else {
//                    conversation.getMessageByFindMessageEntity(number, message, new ValueCallBack<List<TIMMessage>>(result) {
//                        @Override
//                        public void onSuccess(List<TIMMessage> timMessages) {
//                            if (timMessages == null || timMessages.size() == 0) {
//                                result.success(JsonUtil.toJSONString(new ArrayList<>()));
//                                return;
//                            }
//                            TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>(result));
//                        }
//                    });
//                }
//            }
//        });
//    }
//    /**
//     * 腾讯云 获得好友列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getFriendList(MethodCall methodCall, final Result result) {
//        TIMFriendshipManager.getInstance().getFriendList(new ValueCallBack<List<TIMFriend>>(result));
//    }
//
//    /**
//     * 腾讯云 获得群组列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getGroupList(MethodCall methodCall, final Result result) {
//        TIMGroupManager.getInstance().getGroupList(new ValueCallBack<List<TIMGroupBaseInfo>>(result) {
//            @Override
//            public void onSuccess(List<TIMGroupBaseInfo> groupBaseInfos) {
//                List<String> ids = new ArrayList<>(groupBaseInfos.size());
//                for (TIMGroupBaseInfo groupBaseInfo : groupBaseInfos) {
//                    ids.add(groupBaseInfo.getGroupId());
//                }
//
//                if (ids.size() == 0) {
//                    result.success(JsonUtil.toJSONString(new ArrayList<>()));
//                    return;
//                }
//
//                // 获得群资料
//                TIMGroupManager.getInstance().getGroupInfo(ids, new ValueCallBack<List<TIMGroupDetailInfoResult>>(result));
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 添加好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void addFriend(MethodCall methodCall, final Result result) {
//        // 用户Id
//        String id = CommonUtil.getParam(methodCall, result, "id");
//        // 添加类型
//        int addType = CommonUtil.getParam(methodCall, result, "addType");
//        // 备注
//        String remark = methodCall.argument("remark");
//        if (remark == null) {
//            remark = "";
//        }
//        // 请求说明
//        String addWording = methodCall.argument("addWording");
//        if (addWording == null) {
//            addWording = "";
//        }
//        // 添加来源
//        String addSource = methodCall.argument("addSource");
//        if (addSource == null) {
//            addSource = "";
//        }
//        // 分组名
//        String friendGroup = methodCall.argument("friendGroup");
//        if (friendGroup == null) {
//            friendGroup = "";
//        }
//
//
//        TIMFriendRequest request = new TIMFriendRequest(id);
//        request.setRemark(remark);
//        request.setAddWording(addWording);
//        request.setAddSource(addSource);
//        request.setFriendGroup(friendGroup);
//        request.setAddType(addType);
//
//        // 添加好友
//        TIMFriendshipManager.getInstance().addFriend(request, new ValueCallBack<TIMFriendResult>(result));
//    }
//
//    /**
//     * 腾讯云 检测单个好友关系
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void checkSingleFriends(MethodCall methodCall, final Result result) {
//        // 用户Id
//        String id = CommonUtil.getParam(methodCall, result, "id");
//        // 类型
//        int type = methodCall.argument("type");
//
//
//        TIMFriendCheckInfo checkInfo = new TIMFriendCheckInfo();
//        checkInfo.setUsers(Collections.singletonList(id));
//        checkInfo.setCheckType(type);
//
//        // 检测关系
//        TIMFriendshipManager.getInstance().checkFriends(checkInfo, new ValueCallBack<List<TIMCheckFriendResult>>(result) {
//            @Override
//            public void onSuccess(List<TIMCheckFriendResult> timCheckFriendResults) {
//                result.success(JsonUtil.toJSONString(timCheckFriendResults.get(0)));
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 获得未决好友列表(申请中)
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getPendencyList(MethodCall methodCall, final Result result) {
//        // 类型
//        int type = CommonUtil.getParam(methodCall, result, "type");
//        // 未决列表序列号。建议客户端保存 seq 和未决列表，请求时填入 server 返回的 seq。如果 seq 是 server 最新的，则不返回数据
//        int seq = methodCall.argument("seq");
//        // 翻页时间戳，只用来翻页，server 返回0时表示没有更多数据，第一次请求填0
//        int timestamp = methodCall.argument("timestamp");
//        // 每页的数量，请求时有效
//        int numPerPage = methodCall.argument("numPerPage");
//
//        // 封装请求对象
//        TIMFriendPendencyRequest request = new TIMFriendPendencyRequest();
//        request.setTimPendencyGetType(type);
//        request.setSeq(seq);
//        request.setTimestamp(timestamp);
//        request.setNumPerPage(numPerPage);
//
//
//        TIMFriendshipManager.getInstance().getPendencyList(request, new ValueCallBack<TIMFriendPendencyResponse>(result) {
//            @Override
//            public void onSuccess(final TIMFriendPendencyResponse timFriendPendencyResponse) {
//                if (timFriendPendencyResponse.getItems().size() == 0) {
//                    result.success(JsonUtil.toJSONString(new HashMap<>()));
//                    return;
//                }
//
//                // 返回结果
//                final List<PendencyEntity> resultData = new ArrayList<>(timFriendPendencyResponse.getItems().size());
//
//                // 用户ID对应用户对象
//                final Map<String, PendencyEntity> map = new HashMap<>();
//
//                // 循环获得的列表，进行对象封装
//                for (TIMFriendPendencyItem item : timFriendPendencyResponse.getItems()) {
//                    map.put(item.getIdentifier(), new PendencyEntity(item));
//                }
//
//                // 获得用户信息
//                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(map.keySet().toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
//                    @Override
//                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
//                        // 设置用户资料
//                        for (TIMUserProfile timUserProfile : timUserProfiles) {
//                            PendencyEntity data = map.get(timUserProfile.getIdentifier());
//                            if (data != null) {
//                                data.setUserProfile(timUserProfile);
//                                resultData.add(data);
//                            }
//                        }
//
//                        // 返回结果
//                        result.success(JsonUtil.toJSONString(new PendencyPageEntiity(timFriendPendencyResponse, resultData)));
//                    }
//                });
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 未决已读上报
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void pendencyReport(MethodCall methodCall, final Result result) {
//        // 已读时间戳，此时间戳以前的消息都将置为已读
//        int timestamp = CommonUtil.getParam(methodCall, result, "timestamp");
//        TIMFriendshipManager.getInstance().pendencyReport(timestamp, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 未决删除
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deletePendency(MethodCall methodCall, final Result result) {
//        // 类型
//        int type = CommonUtil.getParam(methodCall, result, "type");
//
//        // 用户Id
//        String id = CommonUtil.getParam(methodCall, result, "id");
//
//        // 删除未决
//        TIMFriendshipManager.getInstance().deletePendency(type, Collections.singletonList(id), new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 未决审核
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void examinePendency(MethodCall methodCall, final Result result) {
//        // 类型
//        int type = CommonUtil.getParam(methodCall, result, "type");
//        // 用户Id
//        String id = CommonUtil.getParam(methodCall, result, "id");
//        // 好友备注
//        String remark = methodCall.argument("remark");
//
//        // 未决审核
//        TIMFriendResponse response = new TIMFriendResponse();
//        response.setIdentifier(id);
//        response.setResponseType(type);
//        response.setRemark(remark);
//        TIMFriendshipManager.getInstance().doResponse(response, new ValueCallBack<TIMFriendResult>(result));
//    }
//
//    /**
//     * 腾讯云 删除会话
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteConversation(MethodCall methodCall, final Result result) {
//        // 会话ID
//        String sessionId = CommonUtil.getParam(methodCall, result, "sessionId");
//        // 会话类型
//        String sessionTypeStr = CommonUtil.getParam(methodCall, result, "sessionType");
//        TIMConversationType sessionType = TIMConversationType.valueOf(sessionTypeStr);
//        // 删除本地缓存（会话内的消息内容）
//        boolean removeCache = CommonUtil.getParam(methodCall, result, "removeCache");
//
//        boolean res;
//        if (removeCache) {
//            res = V2TIMManager.getInstance().deleteConversationAndLocalMsgs(sessionType, sessionId);
//        } else {
//            res = V2TIMManager.getInstance().deleteConversation(sessionType, sessionId);
//        }
//        result.success(res);
//    }
//
//    /**
//     * 腾讯云 删除会话内的本地聊天记录
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteLocalMessage(MethodCall methodCall, final Result result) {
//        // 会话ID
//        String sessionId = CommonUtil.getParam(methodCall, result, "sessionId");
//        // 会话类型
//        String sessionTypeStr = CommonUtil.getParam(methodCall, result, "sessionType");
//
//
//        // 获得会话信息
//        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
//        conversation.deleteLocalMessage(new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 创建群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void createGroup(MethodCall methodCall, final Result result) {
//        // 群类型
//        String type = CommonUtil.getParam(methodCall, result, "type");
//        // 群名称
//        String name = CommonUtil.getParam(methodCall, result, "name");
//        // 群ID
//        String groupId = methodCall.argument("groupId");
//        // 群公告
//        String notification = methodCall.argument("notification");
//        // 群简介
//        String introduction = methodCall.argument("introduction");
//        // 群头像
//        String faceUrl = methodCall.argument("faceUrl");
//        // 加群选项
//        String addOption = methodCall.argument("addOption");
//        // 最大群成员数
//        Integer maxMemberNum = methodCall.argument("maxMemberNum");
//        // 默认群成员
//        List<TIMGroupMemberInfo> members = methodCall.argument("members") == null ? new ArrayList() : new ArrayList<TIMGroupMemberInfo>(JSON.parseArray(CommonUtil.getParam(methodCall, result, "members").toString(), GroupMemberInfo.class));
//        // 自定义信息
//        String customInfo = methodCall.argument("customInfo");
//
//        // 创建参数对象
//        TIMGroupManager.CreateGroupParam param = new TIMGroupManager.CreateGroupParam(type, name);
//        param.setGroupId(groupId);
//        param.setNotification(notification);
//        param.setIntroduction(introduction);
//        param.setFaceUrl(faceUrl);
//        param.setMembers(members);
//        param.setAddOption(addOption != null ? TIMGroupAddOpt.valueOf(addOption) : null);
//        if (maxMemberNum != null) {
//            param.setMaxMemberNum(maxMemberNum);
//        }
//        try {
//            if (customInfo != null) {
//                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
//                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
//                for (String s : customInfoData.keySet()) {
//                    if (customInfoData.get(s) != null) {
//                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
//                    }
//                }
//                for (String key : customInfoParams.keySet()) {
//                    param.setCustomInfo(key, customInfoParams.get(key));
//                }
//            }
//        } catch (Exception e) {
//            Log.e(TAG, "modifyGroupInfo: set customInfo error", e);
//        }
//
//        // 创建群
//        TIMGroupManager.getInstance().createGroup(param, new ValueCallBack<String>(result) {
//            @Override
//            public void onSuccess(String s) {
//                result.success(s);
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 邀请加入群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void inviteGroupMember(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 用户ID集合
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//
//        TIMGroupManager.getInstance().inviteGroupMember(groupId, ids, new ValueCallBack<List<TIMGroupMemberResult>>(result));
//    }
//
//    /**
//     * 腾讯云 申请加入群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void applyJoinGroup(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 申请理由
//        String reason = CommonUtil.getParam(methodCall, result, "reason");
//
//        TIMGroupManager.getInstance().applyJoinGroup(groupId, reason, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 退出群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void quitGroup(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//
//        TIMGroupManager.getInstance().quitGroup(groupId, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 删除群组成员
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteGroupMember(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 用户ID集合
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        // 删除理由
//        String reason = methodCall.argument("reason");
//
//        TIMGroupManager.getInstance().deleteGroupMember(new TIMGroupManager.DeleteMemberParam(groupId, ids).setReason(reason), new ValueCallBack<List<TIMGroupMemberResult>>(result));
//    }
//
//    /**
//     * 腾讯云 获取群成员列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getGroupMembers(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//
//        TIMGroupManager.getInstance().getGroupMembers(groupId, new ValueCallBack<List<TIMGroupMemberInfo>>(result) {
//            @Override
//            public void onSuccess(List<TIMGroupMemberInfo> timGroupMemberInfos) {
//                final Map<String, GroupMemberEntity> userInfo = new HashMap<>(timGroupMemberInfos.size(), 1);
//                for (TIMGroupMemberInfo timGroupMemberInfo : timGroupMemberInfos) {
//                    GroupMemberEntity user = userInfo.get(timGroupMemberInfo.getUser());
//                    if (user == null) {
//                        user = new GroupMemberEntity(timGroupMemberInfo);
//                    }
//                    userInfo.put(timGroupMemberInfo.getUser(), user);
//                }
//
//                // 获得用户资料
//                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
//                    @Override
//                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
//                        List<GroupMemberEntity> resultData = new ArrayList<>(userInfo.size());
//
//                        for (TIMUserProfile timUserProfile : timUserProfiles) {
//                            GroupMemberEntity entity = userInfo.get(timUserProfile.getIdentifier());
//                            if (entity != null) {
//                                entity.setUserProfile(timUserProfile);
//                            }
//                            resultData.add(entity);
//                        }
//                        result.success(JsonUtil.toJSONString(resultData));
//                    }
//                });
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 解散群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteGroup(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//
//        TIMGroupManager.getInstance().deleteGroup(groupId, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 转让群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void modifyGroupOwner(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 新群主ID
//        String identifier = CommonUtil.getParam(methodCall, result, "identifier");
//
//        TIMGroupManager.getInstance().modifyGroupOwner(groupId, identifier, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 修改群资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void modifyGroupInfo(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 群名
//        String groupName = methodCall.argument("groupName");
//        // 公告
//        String notification = methodCall.argument("notification");
//        // 简介
//        String introduction = methodCall.argument("introduction");
//        // 群头像
//        String faceUrl = methodCall.argument("faceUrl");
//        // 加群选项
//        String addOption = methodCall.argument("addOption");
//        // 最大群成员数
//        Integer maxMemberNum = methodCall.argument("maxMemberNum");
//        // 是否对外可见
//        Boolean visable = methodCall.argument("visable");
//        // 全员禁言
//        Boolean silenceAll = methodCall.argument("silenceAll");
//        // 自定义信息
//        String customInfo = methodCall.argument("customInfo");
//
//        TIMGroupManager.ModifyGroupInfoParam param = new TIMGroupManager.ModifyGroupInfoParam(groupId);
//        param.setGroupName(groupName);
//        param.setNotification(notification);
//        param.setIntroduction(introduction);
//        param.setFaceUrl(faceUrl);
//        param.setAddOption(addOption == null ? null : TIMGroupAddOpt.valueOf(addOption));
//        if (maxMemberNum != null) {
//            param.setMaxMemberNum(maxMemberNum);
//        }
//        if (visable != null) {
//            param.setVisable(visable);
//        }
//        if (silenceAll != null) {
//            param.setSearchable(silenceAll);
//        }
//        try {
//            if (customInfo != null) {
//                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
//                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
//                for (String s : customInfoData.keySet()) {
//                    if (customInfoData.get(s) != null) {
//                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
//                    }
//                }
//                param.setCustomInfo(customInfoParams);
//            }
//        } catch (Exception e) {
//            Log.e(TAG, "modifyGroupInfo: set customInfo error", e);
//        }
//        TIMGroupManager.getInstance().modifyGroupInfo(param, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 修改群成员资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void modifyMemberInfo(MethodCall methodCall, final Result result) {
//        // 群ID
//        String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 群成员ID
//        String identifier = CommonUtil.getParam(methodCall, result, "identifier");
//        // 名片
//        String nameCard = methodCall.argument("nameCard");
//        // 接收消息选项
//        String receiveMessageOpt = methodCall.argument("receiveMessageOpt");
//        // 禁言时间
//        Long silence = null;
//        if (methodCall.argument("silence") != null) {
//            silence = Long.parseLong(methodCall.argument("silence").toString());
//        }
//        // 角色
//        Integer role = methodCall.argument("role");
//        // 自定义信息
//        String customInfo = methodCall.argument("customInfo");
//
//        TIMGroupManager.ModifyMemberInfoParam param = new TIMGroupManager.ModifyMemberInfoParam(groupId, identifier);
//        if (nameCard != null) {
//            param.setNameCard(nameCard);
//        }
//        if (receiveMessageOpt != null) {
//            param.setReceiveMessageOpt(TIMGroupReceiveMessageOpt.valueOf(receiveMessageOpt));
//        }
//        if (silence != null) {
//            param.setSilence(silence);
//        }
//        if (role != null) {
//            param.setRoleType(role);
//        }
//        if (customInfo != null) {
//            try {
//                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
//                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
//                for (String s : customInfoData.keySet()) {
//                    if (customInfoData.get(s) != null) {
//                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
//                    }
//                }
//                param.setCustomInfo(customInfoParams);
//            } catch (Exception e) {
//                Log.e(TAG, "modifyMemberInfo: set customInfo error", e);
//            }
//        }
//        TIMGroupManager.getInstance().modifyMemberInfo(param, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 获得未决群列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getGroupPendencyList(MethodCall methodCall, final Result result) {
//        // 翻页时间戳，只用来翻页，server 返回0时表示没有更多数据，第一次请求填0
//        Long timestamp = null;
//        if (methodCall.argument("timestamp") != null) {
//            timestamp = Long.parseLong(methodCall.argument("timestamp").toString());
//        }
//        // 每页的数量，请求时有效
//        Long numPerPage = null;
//        if (methodCall.argument("numPerPage") != null) {
//            numPerPage = Long.parseLong(methodCall.argument("numPerPage").toString());
//        }
//
//        // 封装请求对象
//        TIMGroupPendencyGetParam request = new TIMGroupPendencyGetParam();
//        if (timestamp != null) {
//            request.setTimestamp(timestamp);
//        }
//        if (numPerPage != null) {
//            request.setNumPerPage(numPerPage);
//        }
//
//        TIMGroupManager.getInstance().getGroupPendencyList(request, new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
//            @Override
//            public void onSuccess(final TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
//                if (timGroupPendencyListGetSucc.getPendencies().size() == 0) {
//                    result.success(JsonUtil.toJSONString(new HashMap<>()));
//                    return;
//                }
//
//                // 存储ID的集合
//                Set<String> groupIds = new HashSet<>();
//                Set<String> userIds = new HashSet<>();
//
//                // 返回结果
//                final List<GroupPendencyEntity> resultData = new ArrayList<>(timGroupPendencyListGetSucc.getPendencies().size());
//                // 循环获得的列表，进行对象封装
//                for (TIMGroupPendencyItem item : timGroupPendencyListGetSucc.getPendencies()) {
//                    resultData.add(new GroupPendencyEntity(item));
//                    groupIds.add(item.getGroupId());
//                    userIds.add(item.getIdentifer());
//                    userIds.add(item.getToUser());
//                }
//
//                // 当前步骤
//                final int[] current = {0};
//
//                // 获得群信息
//                TIMGroupManager.getInstance().getGroupInfo(Arrays.asList(groupIds.toArray(new String[0])), new ValueCallBack<List<TIMGroupDetailInfoResult>>(result) {
//                    @Override
//                    public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
//                        // 循环赋值
//                        for (GroupPendencyEntity resultDatum : resultData) {
//                            for (TIMGroupDetailInfoResult timGroupDetailInfoResult : timGroupDetailInfoResults) {
//                                if (timGroupDetailInfoResult.getGroupId().equals(resultDatum.getGroupId())) {
//                                    resultDatum.setGroupInfo(timGroupDetailInfoResult);
//                                }
//                            }
//                        }
//                        current[0]++;
//                        if (current[0] >= 2) {
//                            result.success(JsonUtil.toJSONString(new GroupPendencyPageEntiity(timGroupPendencyListGetSucc.getPendencyMeta(), resultData)));
//                        }
//                    }
//                });
//
//                // 获得用户信息
//                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userIds.toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
//                    @Override
//                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
//                        // 循环赋值
//                        for (GroupPendencyEntity resultDatum : resultData) {
//                            for (TIMUserProfile timUserProfile : timUserProfiles) {
//                                // 申请人信息
//                                if (timUserProfile.getIdentifier().equals(resultDatum.getIdentifier())) {
//                                    resultDatum.setApplyUserInfo(timUserProfile);
//                                }
//                                // 处理人信息
//                                if (timUserProfile.getIdentifier().equals(resultDatum.getToUser())) {
//                                    resultDatum.setHandlerUserInfo(timUserProfile);
//                                }
//                            }
//                        }
//                        current[0]++;
//                        if (current[0] >= 2) {
//                            result.success(JsonUtil.toJSONString(new GroupPendencyPageEntiity(timGroupPendencyListGetSucc.getPendencyMeta(), resultData)));
//                        }
//                    }
//                });
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 上报未决已读
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void reportGroupPendency(MethodCall methodCall, final Result result) {
//        // 已读时间戳
//        Long timestamp = Long.parseLong(CommonUtil.getParam(methodCall, result, "timestamp").toString());
//        TIMGroupManager.getInstance().reportGroupPendency(timestamp, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 同意申请
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void groupPendencyAccept(MethodCall methodCall, final Result result) {
//        // 理由
//        final String msg = methodCall.argument("msg");
//        // 群ID
//        final String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 申请人ID
//        final String identifier = CommonUtil.getParam(methodCall, result, "identifier");
//        // 申请时间
//        final long addTime = Long.parseLong(CommonUtil.getParam(methodCall, result, "addTime").toString());
//
//        TIMGroupManager.getInstance().getGroupPendencyList(new TIMGroupPendencyGetParam(), new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
//            @Override
//            public void onSuccess(TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
//                List<TIMGroupPendencyItem> data = timGroupPendencyListGetSucc.getPendencies();
//                if (data != null) {
//                    for (TIMGroupPendencyItem datum : data) {
//                        if (datum.getGroupId().equals(groupId) && datum.getIdentifer().equals(identifier) && datum.getAddTime() == addTime) {
//                            datum.accept(msg, new VoidCallBack(result));
//                            break;
//                        }
//                    }
//                }
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 拒绝申请
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void groupPendencyRefuse(MethodCall methodCall, final Result result) {
//        // 理由
//        final String msg = methodCall.argument("msg");
//        // 群ID
//        final String groupId = CommonUtil.getParam(methodCall, result, "groupId");
//        // 申请人ID
//        final String identifier = CommonUtil.getParam(methodCall, result, "identifier");
//        // 申请时间
//        final long addTime = Long.parseLong(CommonUtil.getParam(methodCall, result, "addTime").toString());
//
//        TIMGroupManager.getInstance().getGroupPendencyList(new TIMGroupPendencyGetParam(), new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
//            @Override
//            public void onSuccess(TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
//                List<TIMGroupPendencyItem> data = timGroupPendencyListGetSucc.getPendencies();
//                if (data != null) {
//                    for (TIMGroupPendencyItem datum : data) {
//                        if (datum.getGroupId().equals(groupId) && datum.getIdentifer().equals(identifier) && datum.getAddTime() == addTime) {
//                            datum.refuse(msg, new VoidCallBack(result));
//                            break;
//                        }
//                    }
//                }
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 获取自己的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getSelfProfile(MethodCall methodCall, final Result result) {
//        // 强制走后台拉取
//        Boolean forceUpdate = methodCall.argument("forceUpdate");
//        if (forceUpdate != null && forceUpdate) {
//            TIMFriendshipManager.getInstance().getSelfProfile(new ValueCallBack<TIMUserProfile>(result));
//        } else {
//            // 先获取本地，再获取服务器
//            TIMUserProfile data = TIMFriendshipManager.getInstance().querySelfProfile();
//            if (data == null) {
//                TIMFriendshipManager.getInstance().getSelfProfile(new ValueCallBack<TIMUserProfile>(result));
//            } else {
//                result.success(JsonUtil.toJSONString(data));
//            }
//        }
//    }
//
//    /**
//     * 腾讯云 修改自己的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void modifySelfProfile(MethodCall methodCall, final Result result) {
//        HashMap params = JSON.parseObject(CommonUtil.getParam(methodCall, result, "params").toString(), HashMap.class);
//        TIMFriendshipManager.getInstance().modifySelfProfile(params, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 修改好友的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void modifyFriend(MethodCall methodCall, final Result result) {
//        String identifier = CommonUtil.getParam(methodCall, result, "identifier");
//        HashMap params = JSON.parseObject(CommonUtil.getParam(methodCall, result, "params").toString(), HashMap.class);
//        TIMFriendshipManager.getInstance().modifyFriend(identifier, params, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 删除好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteFriends(MethodCall methodCall, final Result result) {
//        int delFriendType = CommonUtil.getParam(methodCall, result, "delFriendType");
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//
//        TIMFriendshipManager.getInstance().deleteFriends(ids, delFriendType, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 添加到黑名单
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void addBlackList(MethodCall methodCall, final Result result) {
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        TIMFriendshipManager.getInstance().addBlackList(ids, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//
//    /**
//     * 腾讯云 从黑名单删除
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteBlackList(MethodCall methodCall, final Result result) {
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        TIMFriendshipManager.getInstance().deleteBlackList(ids, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 获得黑名单列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getBlackList(MethodCall methodCall, final Result result) {
//        TIMFriendshipManager.getInstance().getBlackList(new ValueCallBack<List<TIMFriend>>(result));
//    }
//
//    /**
//     * 腾讯云 创建好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void createFriendGroup(MethodCall methodCall, final Result result) {
//        List<String> groupNames = Arrays.asList(CommonUtil.getParam(methodCall, result, "groupNames").toString().split(","));
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        TIMFriendshipManager.getInstance().createFriendGroup(groupNames, ids, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 删除好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteFriendGroup(MethodCall methodCall, final Result result) {
//        List<String> groupNames = Arrays.asList(CommonUtil.getParam(methodCall, result, "groupNames").toString().split(","));
//        TIMFriendshipManager.getInstance().deleteFriendGroup(groupNames, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 添加好友到某个分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void addFriendsToFriendGroup(MethodCall methodCall, final Result result) {
//        String groupName = CommonUtil.getParam(methodCall, result, "groupName");
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        TIMFriendshipManager.getInstance().addFriendsToFriendGroup(groupName, ids, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 从分组删除好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void deleteFriendsFromFriendGroup(MethodCall methodCall, final Result result) {
//        String groupName = CommonUtil.getParam(methodCall, result, "groupName");
//        List<String> ids = Arrays.asList(CommonUtil.getParam(methodCall, result, "ids").toString().split(","));
//        TIMFriendshipManager.getInstance().deleteFriendsFromFriendGroup(groupName, ids, new ValueCallBack<List<TIMFriendResult>>(result));
//    }
//
//    /**
//     * 腾讯云 重命名分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void renameFriendGroup(MethodCall methodCall, final Result result) {
//        String oldGroupName = CommonUtil.getParam(methodCall, result, "oldGroupName");
//        String newGroupName = CommonUtil.getParam(methodCall, result, "newGroupName");
//        TIMFriendshipManager.getInstance().renameFriendGroup(oldGroupName, newGroupName, new VoidCallBack(result));
//    }
//
//    /**
//     * 腾讯云 获得好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void getFriendGroups(MethodCall methodCall, final Result result) {
//        String groupNamesStr = methodCall.argument("groupNames");
//        List<String> groupNames = null;
//        if (groupNamesStr != null) {
//            groupNames = Arrays.asList(groupNamesStr.split(","));
//        }
//        TIMFriendshipManager.getInstance().getFriendGroups(groupNames, new ValueCallBack<List<TIMFriendGroup>>(result));
//    }
//
//    /**
//     * 腾讯云 删除消息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void removeMessage(MethodCall methodCall, final Result result) {
//        // 获得消息后删除
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                result.success(message.remove());
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 设置自定义整型
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void setMessageCustomInt(MethodCall methodCall, final Result result) {
//        final int value = CommonUtil.getParam(methodCall, result, "value");
//        // 获得消息后设置
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                message.setCustomInt(value);
//                result.success(null);
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 设置自定义字符串
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void setMessageCustomStr(MethodCall methodCall, final Result result) {
//        final String value = CommonUtil.getParam(methodCall, result, "value");
//
//        // 获得消息后设置
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                message.setCustomStr(value);
//                result.success(null);
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 获得视频缩略图
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void downloadVideoImage(MethodCall methodCall, final Result result) {
//        final String path = methodCall.argument("path");
//
//        // 如果文件存在，则不进行下一步操作
//        if (path != null && new File(path).exists()) {
//            result.success(path);
//            return;
//        }
//
//        // 获得消息后设置
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                TIMElem elem = message.getElement(0);
//                if (elem.getType() == TIMElemType.Video) {
//                    final TIMVideoElem videoElem = (TIMVideoElem) elem;
//                    // 如果没有填充目录，则获得临时目录
//                    String finalPath = path;
//                    if (finalPath == null || "".equals(finalPath)) {
//                        finalPath = context.getExternalCacheDir().getPath() + File.separator + videoElem.getSnapshotInfo().getUuid();
//                    }
//
//                    // 如果文件存在则不进行下载
//                    if (new File(finalPath).exists()) {
//                        result.success(finalPath);
//                        return;
//                    }
//
//                    final String finalPath1 = finalPath;
//                    // 获得消息信息
//                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
//                        @Override
//                        public void onSuccess(final List<MessageEntity> messageEntities) {
//                            // 下载图片
//                            videoElem.getSnapshotInfo().getImage(finalPath1, new ValueCallBack<ProgressInfo>(result) {
//                                @Override
//                                public void onSuccess(ProgressInfo progressInfo) {
//                                    Map<String, Object> params = new HashMap<>(3, 1);
//                                    params.put("message", messageEntities.get(0));
//                                    params.put("path", finalPath1);
//                                    params.put("currentSize", progressInfo.getCurrentSize());
//                                    params.put("totalSize", progressInfo.getTotalSize());
//                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
//                                }
//                            }, new VoidCallBack(result) {
//                                @Override
//                                public void onSuccess() {
//                                    result.success(finalPath1);
//                                }
//                            });
//                        }
//                    });
//                }
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 下载视频
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void downloadVideo(MethodCall methodCall, final Result result) {
//        final String path = methodCall.argument("path");
//
//        // 如果文件存在，则不进行下一步操作
//        if (path != null && new File(path).exists()) {
//            result.success(path);
//            return;
//        }
//
//        // 获得消息后设置
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                TIMElem elem = message.getElement(0);
//                if (elem.getType() == TIMElemType.Video) {
//                    final TIMVideoElem videoElem = (TIMVideoElem) elem;
//                    // 如果没有填充目录，则获得临时目录
//                    String finalPath = path;
//                    if (finalPath == null || "".equals(finalPath)) {
//                        finalPath = context.getExternalCacheDir().getPath() + File.separator + videoElem.getVideoInfo().getUuid();
//                    }
//
//                    // 如果文件存在则不进行下载
//                    if (new File(finalPath).exists()) {
//                        result.success(finalPath);
//                        return;
//                    }
//
//                    final String finalPath1 = finalPath;
//                    // 获得消息信息
//                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
//                        @Override
//                        public void onSuccess(final List<MessageEntity> messageEntities) {
//                            // 下载视频
//                            videoElem.getVideoInfo().getVideo(finalPath1, new ValueCallBack<ProgressInfo>(result) {
//                                @Override
//                                public void onSuccess(ProgressInfo progressInfo) {
//                                    Map<String, Object> params = new HashMap<>(3, 1);
//                                    params.put("message", messageEntities.get(0));
//                                    params.put("path", finalPath1);
//                                    params.put("currentSize", progressInfo.getCurrentSize());
//                                    params.put("totalSize", progressInfo.getTotalSize());
//                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
//                                }
//                            }, new VoidCallBack(result) {
//                                @Override
//                                public void onSuccess() {
//                                    result.success(finalPath1);
//                                }
//                            });
//                        }
//                    });
//                }
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 下载语音
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void downloadSound(MethodCall methodCall, final Result result) {
//        final String path = methodCall.argument("path");
//
//        // 如果文件存在，则不进行下一步操作
//        if (path != null && new File(path).exists()) {
//            result.success(path);
//            return;
//        }
//
//        // 获得消息后设置
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(TIMMessage message) {
//                TIMElem elem = message.getElement(0);
//                if (elem.getType() == TIMElemType.Sound) {
//                    final TIMSoundElem soundElem = (TIMSoundElem) elem;
//                    // 如果没有填充目录，则获得临时目录
//                    String finalPath = path;
//                    if (finalPath == null || "".equals(finalPath)) {
//                        finalPath = context.getExternalCacheDir().getPath() + File.separator + soundElem.getUuid();
//                    }
//
//                    // 如果文件存在则不进行下载
//                    if (new File(finalPath).exists()) {
//                        result.success(finalPath);
//                        return;
//                    }
//
//                    final String finalPath1 = finalPath;
//                    // 获得消息信息
//                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
//                        @Override
//                        public void onSuccess(final List<MessageEntity> messageEntities) {
//                            // 下载语音
//                            soundElem.getSoundToFile(finalPath1, new ValueCallBack<ProgressInfo>(result) {
//                                @Override
//                                public void onSuccess(ProgressInfo progressInfo) {
//                                    Map<String, Object> params = new HashMap<>(3, 1);
//                                    params.put("message", messageEntities.get(0));
//                                    params.put("path", finalPath1);
//                                    params.put("currentSize", progressInfo.getCurrentSize());
//                                    params.put("totalSize", progressInfo.getTotalSize());
//                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
//                                }
//                            }, new VoidCallBack(result) {
//                                @Override
//                                public void onSuccess() {
//                                    result.success(finalPath1);
//                                }
//                            });
//                        }
//                    });
//                }
//            }
//        });
//    }
//
//    /**
//     * 腾讯云 查找一条消息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void findMessage(MethodCall methodCall, final Result result) {
//        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
//            @Override
//            public void onSuccess(final TIMMessage message) {
//                TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result));
//            }
//        });
//    }
//
//
//    /**
//     * 腾讯云 设置离线推送设置
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void setOfflinePushSettings(MethodCall methodCall, final Result result) {
//        TIMOfflinePushSettings settings = new TIMOfflinePushSettings();
//        Boolean enabled = methodCall.argument("enabled");
//        if (enabled != null) {
//            settings.setEnabled(true);
//        }
//        String c2cSound = methodCall.argument("c2cSound");
//        if (c2cSound != null) {
//            settings.setC2cMsgRemindSound(Uri.fromFile(new File(c2cSound)));
//        }
//        String groupSound = methodCall.argument("groupSound");
//        if (groupSound != null) {
//            settings.setGroupMsgRemindSound(Uri.fromFile(new File(groupSound)));
//        }
//        String videoSound = methodCall.argument("videoSound");
//        if (videoSound != null) {
//            settings.setVideoSound(Uri.fromFile(new File(videoSound)));
//        }
//        V2TIMManager.getInstance().setOfflinePushSettings(settings);
//        result.success(null);
//    }
//
//    /**
//     * 腾讯云 设置离线推送Token
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private void setOfflinePushToken(MethodCall methodCall, final Result result) {
//        String token = CommonUtil.getParam(methodCall, result, "token");
//        Long bussid = Long.parseLong(CommonUtil.getParam(methodCall, result, "bussid").toString());
//        V2TIMManager.getInstance().setOfflinePushToken(new TIMOfflinePushToken(bussid, token), new VoidCallBack(result));
//    }
//
}