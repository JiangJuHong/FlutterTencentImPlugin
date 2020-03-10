package top.huic.tencent_im_plugin;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.tencent.imsdk.TIMConnListener;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupAddOpt;
import com.tencent.imsdk.TIMGroupEventListener;
import com.tencent.imsdk.TIMGroupManager;
import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMGroupReceiveMessageOpt;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMLogLevel;
import com.tencent.imsdk.TIMLogListener;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMMessageListener;
import com.tencent.imsdk.TIMRefreshListener;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMSoundElem;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMUserConfig;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMUserStatusListener;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;
import com.tencent.imsdk.conversation.Msg;
import com.tencent.imsdk.ext.group.TIMGroupBaseInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;
import com.tencent.imsdk.ext.group.TIMGroupMemberResult;
import com.tencent.imsdk.ext.group.TIMGroupPendencyGetParam;
import com.tencent.imsdk.ext.group.TIMGroupPendencyItem;
import com.tencent.imsdk.ext.group.TIMGroupPendencyListGetSucc;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMMessageReceipt;
import com.tencent.imsdk.ext.message.TIMMessageReceiptListener;
import com.tencent.imsdk.ext.message.TIMMessageRevokedListener;
import com.tencent.imsdk.friendship.TIMCheckFriendResult;
import com.tencent.imsdk.friendship.TIMFriend;
import com.tencent.imsdk.friendship.TIMFriendCheckInfo;
import com.tencent.imsdk.friendship.TIMFriendGroup;
import com.tencent.imsdk.friendship.TIMFriendPendencyItem;
import com.tencent.imsdk.friendship.TIMFriendPendencyRequest;
import com.tencent.imsdk.friendship.TIMFriendPendencyResponse;
import com.tencent.imsdk.friendship.TIMFriendRequest;
import com.tencent.imsdk.friendship.TIMFriendResponse;
import com.tencent.imsdk.friendship.TIMFriendResult;
import com.tencent.imsdk.session.SessionWrapper;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import top.huic.tencent_im_plugin.entity.GroupMemberEntity;
import top.huic.tencent_im_plugin.entity.GroupPendencyEntity;
import top.huic.tencent_im_plugin.entity.GroupPendencyPageEntiity;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.PendencyEntity;
import top.huic.tencent_im_plugin.entity.PendencyPageEntiity;
import top.huic.tencent_im_plugin.entity.SessionEntity;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;
import top.huic.tencent_im_plugin.listener.TencentImListener;
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
        Log.d(TAG, "onMethodCall: " + call.method + ",param:" + call.arguments);
        switch (call.method) {
            case "init":
                this.init(call, result);
                break;
            case "login":
                this.login(call, result);
                break;
            case "logout":
                this.logout(call, result);
                break;
            case "getLoginUser":
                this.getLoginUser(call, result);
                break;
            case "initStorage":
                this.initStorage(call, result);
                break;
            case "getConversationList":
                this.getConversationList(call, result);
                break;
            case "getConversation":
                this.getConversation(call, result);
                break;
            case "getGroupInfo":
                this.getGroupInfo(call, result);
                break;
            case "getUserInfo":
                this.getUserInfo(call, result);
                break;
            case "getMessages":
                this.getMessages(call, result);
                break;
            case "getLocalMessages":
                this.getLocalMessages(call, result);
                break;
            case "setRead":
                this.setRead(call, result);
                break;
            case "sendCustomMessage":
                this.sendCustomMessage(call, result);
                break;
            case "sendTextMessage":
                this.sendTextMessage(call, result);
                break;
            case "sendSoundMessage":
                this.sendSoundMessage(call, result);
                break;
            case "sendImageMessage":
                this.sendImageMessage(call, result);
                break;
            case "sendVideoMessage":
                this.sendVideoMessage(call, result);
                break;
            case "getFriendList":
                this.getFriendList(call, result);
                break;
            case "getGroupList":
                this.getGroupList(call, result);
                break;
            case "addFriend":
                this.addFriend(call, result);
                break;
            case "checkSingleFriends":
                this.checkSingleFriends(call, result);
                break;
            case "getPendencyList":
                this.getPendencyList(call, result);
                break;
            case "pendencyReport":
                this.pendencyReport(call, result);
                break;
            case "deletePendency":
                this.deletePendency(call, result);
                break;
            case "examinePendency":
                this.examinePendency(call, result);
                break;
            case "deleteConversation":
                this.deleteConversation(call, result);
                break;
            case "deleteLocalMessage":
                this.deleteLocalMessage(call, result);
                break;
            case "createGroup":
                this.createGroup(call, result);
                break;
            case "inviteGroupMember":
                this.inviteGroupMember(call, result);
                break;
            case "applyJoinGroup":
                this.applyJoinGroup(call, result);
                break;
            case "quitGroup":
                this.quitGroup(call, result);
                break;
            case "deleteGroupMember":
                this.deleteGroupMember(call, result);
                break;
            case "getGroupMembers":
                this.getGroupMembers(call, result);
                break;
            case "deleteGroup":
                this.deleteGroup(call, result);
                break;
            case "modifyGroupOwner":
                this.modifyGroupOwner(call, result);
            case "modifyGroupInfo":
                this.modifyGroupInfo(call, result);
                break;
            case "modifyMemberInfo":
                this.modifyMemberInfo(call, result);
                break;
            case "getGroupPendencyList":
                this.getGroupPendencyList(call, result);
                break;
            case "reportGroupPendency":
                this.reportGroupPendency(call, result);
                break;
            case "groupPendencyAccept":
                this.groupPendencyAccept(call, result);
                break;
            case "groupPendencyRefuse":
                this.groupPendencyRefuse(call, result);
                break;
            case "getSelfProfile":
                this.getSelfProfile(call, result);
                break;
            case "modifySelfProfile":
                this.modifySelfProfile(call, result);
                break;
            case "modifyFriend":
                this.modifyFriend(call, result);
                break;
            case "deleteFriends":
                this.deleteFriends(call, result);
                break;
            case "addBlackList":
                this.addBlackList(call, result);
                break;
            case "deleteBlackList":
                this.deleteBlackList(call, result);
                break;
            case "getBlackList":
                this.getBlackList(call, result);
                break;
            case "createFriendGroup":
                this.createFriendGroup(call, result);
                break;
            case "deleteFriendGroup":
                this.deleteFriendGroup(call, result);
                break;
            case "addFriendsToFriendGroup":
                this.addFriendsToFriendGroup(call, result);
                break;
            case "deleteFriendsFromFriendGroup":
                this.deleteFriendsFromFriendGroup(call, result);
                break;
            case "renameFriendGroup":
                this.renameFriendGroup(call, result);
                break;
            case "getFriendGroups":
                this.getFriendGroups(call, result);
                break;
            case "revokeMessage":
                this.revokeMessage(call, result);
                break;
            case "removeMessage":
                this.removeMessage(call, result);
                break;
            case "setMessageCustomInt":
                this.setMessageCustomInt(call, result);
                break;
            case "setMessageCustomStr":
                this.setMessageCustomStr(call, result);
                break;
            default:
                Log.w(TAG, "onMethodCall: not found method " + call.method);
                result.notImplemented();
        }
    }


    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        Log.d(TAG, "onDetachedFromEngine: ");
    }

    /**
     * 腾讯云Im初始化事件
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void init(MethodCall methodCall, Result result) {
        // 应用appid
        String appid = this.getParam(methodCall, result, "appid");

        // 主线程才初始化SDK
        if (SessionWrapper.isMainProcess(context)) {
            TencentImListener listener = new TencentImListener(TencentImPlugin.channel);

            // 初始化 SDK
            TIMManager.getInstance().init(context, new TIMSdkConfig(Integer.parseInt(appid))
                    .enableLogPrint(true)
                    .setLogLevel(TIMLogLevel.WARN)
            );

            // 基本用户配置
            TIMUserConfig userConfig = new TIMUserConfig()
                    .setUserStatusListener(listener)
                    .setConnectionListener(listener)
                    .setGroupEventListener(listener)
                    .setRefreshListener(listener)
                    .setMessageRevokedListener(listener)
                    .setMessageReceiptListener(listener)
                    .enableReadReceipt(true);


            TIMManager.getInstance().setUserConfig(userConfig);

            // 添加消息监听器
            TIMManager.getInstance().addMessageListener(listener);
        }

        result.success(null);
    }

    /**
     * 腾讯云 IM 登录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void login(MethodCall methodCall, final Result result) {
        // 用户ID和签名
        final String identifier = this.getParam(methodCall, result, "identifier");
        String userSig = this.getParam(methodCall, result, "userSig");

        // 如果用户已登录，则不允许重复登录
        if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
            result.error("login failed. ", "user is login", "user is already login ,you should login out first");
            return;
        }

        // 登录操作
        TIMManager.getInstance().login(identifier, userSig, new VoidCallBack(result));
    }

    /**
     * 腾讯云 IM 退出登录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void logout(MethodCall methodCall, final Result result) {
        if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
            TIMManager.getInstance().logout(new VoidCallBack(result));
        }
    }

    /**
     * 腾讯云 获得当前登录用户
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLoginUser(MethodCall methodCall, final Result result) {
        result.success(TIMManager.getInstance().getLoginUser());
    }

    /**
     * 腾讯云 初始化本地存储
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void initStorage(MethodCall methodCall, final Result result) {
        // 用户ID
        String identifier = this.getParam(methodCall, result, "identifier");
        //初始化本地存储
        TIMManager.getInstance().initStorage(identifier, new VoidCallBack(result));
    }

    /**
     * 腾讯云 获得当前登录用户会话列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getConversationList(MethodCall methodCall, final Result result) {
        TencentImUtils.getConversationInfo(new ValueCallBack<List<SessionEntity>>(result), TIMManager.getInstance().getConversationList());
    }

    /**
     * 腾讯云 根据ID获得会话
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getConversation(MethodCall methodCall, final Result result) {
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TencentImUtils.getConversationInfo(new ValueCallBack<List<SessionEntity>>(result) {
            @Override
            public void onSuccess(List<SessionEntity> sessionEntities) {
                result.success(JsonUtil.toJSONString(sessionEntities.get(0)));
            }
        }, Collections.singletonList(conversation));
    }

    /**
     * 腾讯云 获得群信息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupInfo(MethodCall methodCall, final Result result) {
        // 群ID
        String id = this.getParam(methodCall, result, "id");
        TIMGroupDetailInfo groupDetailInfo = TIMGroupManager.getInstance().queryGroupInfo(id);
        if (groupDetailInfo == null) {
            TIMGroupManager.getInstance().getGroupInfo(Collections.singletonList(id), new ValueCallBack<List<TIMGroupDetailInfoResult>>(result) {
                @Override
                public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                    if (timGroupDetailInfoResults != null && timGroupDetailInfoResults.size() >= 1) {
                        result.success(JsonUtil.toJSONString(timGroupDetailInfoResults.get(0)));
                    } else {
                        result.success(null);
                    }
                }
            });
        } else {
            result.success(JsonUtil.toJSONString(groupDetailInfo));
        }
    }

    /**
     * 腾讯云 获得用户信息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getUserInfo(MethodCall methodCall, final Result result) {
        // 用户ID
        String id = this.getParam(methodCall, result, "id");
        boolean forceUpdate = this.getParam(methodCall, result, "forceUpdate");
        TIMFriendshipManager.getInstance().getUsersProfile(Collections.singletonList(id), forceUpdate, new ValueCallBack<List<TIMUserProfile>>(result) {
            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                if (timUserProfiles != null && timUserProfiles.size() >= 1) {
                    result.success(JsonUtil.toJSONString(timUserProfiles.get(0)));
                } else {
                    result.success(null);
                }
            }
        });
    }

    /**
     * 腾讯云 设置会话消息为已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setRead(MethodCall methodCall, final Result result) {
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        // 设置已读
        conversation.setReadMessage(null, new VoidCallBack(result));

    }


    /**
     * 腾讯云 获得消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getMessages(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getMessages: ");
        this.getMessages(methodCall, result, false);
    }

    /**
     * 腾讯云 获得本地消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLocalMessages(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getLocalMessage: ");
        this.getMessages(methodCall, result, true);
    }

    /**
     * 获得消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     * @param local      是否是获取本地消息
     */
    private void getMessages(MethodCall methodCall, final Result result, boolean local) {
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 消息数量
        Integer number = this.getParam(methodCall, result, "number");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 获得聊天记录
        if (local) {
            conversation.getLocalMessage(number, null, new ValueCallBack<List<TIMMessage>>(result) {
                @Override
                public void onSuccess(List<TIMMessage> timMessages) {
                    if (timMessages == null || timMessages.size() == 0) {
                        result.success(JsonUtil.toJSONString(new ArrayList<>()));
                        return;
                    }
                    TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>(result));
                }
            });
        } else {
            conversation.getMessage(number, null, new ValueCallBack<List<TIMMessage>>(result) {
                @Override
                public void onSuccess(List<TIMMessage> timMessages) {
                    if (timMessages == null || timMessages.size() == 0) {
                        result.success(JsonUtil.toJSONString(new ArrayList<>()));
                        return;
                    }
                    TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>(result));
                }
            });
        }
    }

    /**
     * 腾讯云 发送自定义消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendCustomMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "sendCustomMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 数据内容
        String data = this.getParam(methodCall, result, "data");
        // 使用使用在线消息发送(无痕)
        boolean ol = this.getParam(methodCall, result, "ol");

        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMCustomElem customElem = new TIMCustomElem();
        customElem.setData(data.getBytes());
        message.addElement(customElem);

        // 发送消息
        this.sendMessage(conversation, message, result, ol);
    }

    /**
     * 腾讯云 发送文本消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendTextMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "sendTextMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 消息内容
        String content = this.getParam(methodCall, result, "content");
        // 使用使用在线消息发送(无痕)
        boolean ol = this.getParam(methodCall, result, "ol");

        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMTextElem textElem = new TIMTextElem();
        textElem.setText(content);
        message.addElement(textElem);

        // 发送消息
        this.sendMessage(conversation, message, result, ol);
    }


    /**
     * 腾讯云 发送语音消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendSoundMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "sendSoundMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 语音路径
        String path = this.getParam(methodCall, result, "path");
        // 语音时长
        Integer duration = this.getParam(methodCall, result, "duration");
        // 使用使用在线消息发送(无痕)
        boolean ol = this.getParam(methodCall, result, "ol");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMSoundElem soundElem = new TIMSoundElem();
        soundElem.setPath(path);
        soundElem.setDuration(duration);
        message.addElement(soundElem);

        // 发送消息
        this.sendMessage(conversation, message, result, ol);
    }

    /**
     * 腾讯云 发送图片消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendImageMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "sendImageMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 图片路径
        String path = this.getParam(methodCall, result, "path");
        // 使用使用在线消息发送(无痕)
        boolean ol = this.getParam(methodCall, result, "ol");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMImageElem imageElem = new TIMImageElem();
        imageElem.setPath(path);
        message.addElement(imageElem);

        // 发送消息
        this.sendMessage(conversation, message, result, ol);
    }

    /**
     * 腾讯云 发送视频消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendVideoMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "sendVideoMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 视频路径
        String path = this.getParam(methodCall, result, "path");
        // 视频类型
        String type = this.getParam(methodCall, result, "type");
        // 视频时长
        Integer duration = this.getParam(methodCall, result, "duration");
        // 快照宽度
        Integer snapshotWidth = this.getParam(methodCall, result, "snapshotWidth");
        // 快照高度
        Integer snapshotHeight = this.getParam(methodCall, result, "snapshotHeight");
        // 快照路径
        String snapshotPath = this.getParam(methodCall, result, "snapshotPath");
        // 使用使用在线消息发送(无痕)
        boolean ol = this.getParam(methodCall, result, "ol");
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMVideoElem videoElem = new TIMVideoElem();


        // 封装视频信息
        TIMVideo video = new TIMVideo();
        video.setType(type);
        video.setDuaration(duration);

        // 封装快照信息
        TIMSnapshot snapshot = new TIMSnapshot();
        snapshot.setWidth(snapshotWidth);
        snapshot.setHeight(snapshotHeight);

        videoElem.setSnapshot(snapshot);
        videoElem.setVideo(video);
        videoElem.setSnapshotPath(snapshotPath);
        videoElem.setVideoPath(path);
        message.addElement(videoElem);

        // 发送消息
        this.sendMessage(conversation, message, result, ol);
    }

    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param result       Flutter返回对象
     * @param ol           是否使用在线消息发送
     */
    private void sendMessage(TIMConversation conversation, TIMMessage message, final Result result, boolean ol) {
        ValueCallBack callBack = new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(final TIMMessage message) {
                TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                    @Override
                    public void onSuccess(List<MessageEntity> messageEntities) {
                        result.success(JsonUtil.toJSONString(messageEntities.get(0)));
                    }
                });
            }
        };

        if (ol) {
            conversation.sendOnlineMessage(message, callBack);
        } else {
            conversation.sendMessage(message, callBack);
        }
    }

    /**
     * 腾讯云 获得好友列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getFriendList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getFriendList: ");
        TIMFriendshipManager.getInstance().getFriendList(new ValueCallBack<List<TIMFriend>>(result));
    }

    /**
     * 腾讯云 获得群组列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getGroupList: ");
        TIMGroupManager.getInstance().getGroupList(new ValueCallBack<List<TIMGroupBaseInfo>>(result) {
            @Override
            public void onSuccess(List<TIMGroupBaseInfo> groupBaseInfos) {
                List<String> ids = new ArrayList<>(groupBaseInfos.size());
                for (TIMGroupBaseInfo groupBaseInfo : groupBaseInfos) {
                    ids.add(groupBaseInfo.getGroupId());
                }

                if (ids.size() == 0) {
                    result.success(JsonUtil.toJSONString(new ArrayList<>()));
                    return;
                }

                // 获得群资料
                TIMGroupManager.getInstance().getGroupInfo(ids, new ValueCallBack<List<TIMGroupDetailInfoResult>>(result));
            }
        });
    }

    /**
     * 腾讯云 添加好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void addFriend(MethodCall methodCall, final Result result) {
        Log.d(TAG, "addFriend: ");

        // 用户Id
        String id = this.getParam(methodCall, result, "id");
        // 添加类型
        int addType = this.getParam(methodCall, result, "addType");
        // 备注
        String remark = methodCall.argument("remark");
        if (remark == null) {
            remark = "";
        }
        // 请求说明
        String addWording = methodCall.argument("addWording");
        if (addWording == null) {
            addWording = "";
        }
        // 添加来源
        String addSource = methodCall.argument("addSource");
        if (addSource == null) {
            addSource = "";
        }
        // 分组名
        String friendGroup = methodCall.argument("friendGroup");
        if (friendGroup == null) {
            friendGroup = "";
        }


        TIMFriendRequest request = new TIMFriendRequest(id);
        request.setRemark(remark);
        request.setAddWording(addWording);
        request.setAddSource(addSource);
        request.setFriendGroup(friendGroup);
        request.setAddType(addType);

        // 添加好友
        TIMFriendshipManager.getInstance().addFriend(request, new ValueCallBack<TIMFriendResult>(result));
    }

    /**
     * 腾讯云 检测单个好友关系
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void checkSingleFriends(MethodCall methodCall, final Result result) {
        Log.d(TAG, "checkSingleFriends: ");

        // 用户Id
        String id = this.getParam(methodCall, result, "id");
        // 类型
        int type = methodCall.argument("type");


        TIMFriendCheckInfo checkInfo = new TIMFriendCheckInfo();
        checkInfo.setUsers(Collections.singletonList(id));
        checkInfo.setCheckType(type);

        // 检测关系
        TIMFriendshipManager.getInstance().checkFriends(checkInfo, new ValueCallBack<List<TIMCheckFriendResult>>(result) {
            @Override
            public void onSuccess(List<TIMCheckFriendResult> timCheckFriendResults) {
                result.success(JsonUtil.toJSONString(timCheckFriendResults.get(0)));
            }
        });
    }

    /**
     * 腾讯云 获得未决好友列表(申请中)
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getPendencyList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getPendencyList: ");
        // 类型
        int type = this.getParam(methodCall, result, "type");
        // 未决列表序列号。建议客户端保存 seq 和未决列表，请求时填入 server 返回的 seq。如果 seq 是 server 最新的，则不返回数据
        int seq = methodCall.argument("seq");
        // 翻页时间戳，只用来翻页，server 返回0时表示没有更多数据，第一次请求填0
        int timestamp = methodCall.argument("timestamp");
        // 每页的数量，请求时有效
        int numPerPage = methodCall.argument("numPerPage");

        // 封装请求对象
        TIMFriendPendencyRequest request = new TIMFriendPendencyRequest();
        request.setTimPendencyGetType(type);
        request.setSeq(seq);
        request.setTimestamp(timestamp);
        request.setNumPerPage(numPerPage);


        TIMFriendshipManager.getInstance().getPendencyList(request, new ValueCallBack<TIMFriendPendencyResponse>(result) {
            @Override
            public void onSuccess(final TIMFriendPendencyResponse timFriendPendencyResponse) {
                if (timFriendPendencyResponse.getItems().size() == 0) {
                    result.success(JsonUtil.toJSONString(new HashMap<>()));
                    return;
                }

                // 返回结果
                final List<PendencyEntity> resultData = new ArrayList<>(timFriendPendencyResponse.getItems().size());

                // 用户ID对应用户对象
                final Map<String, PendencyEntity> map = new HashMap<>();

                // 循环获得的列表，进行对象封装
                for (TIMFriendPendencyItem item : timFriendPendencyResponse.getItems()) {
                    map.put(item.getIdentifier(), new PendencyEntity(item));
                }

                // 获得用户信息
                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(map.keySet().toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
                    @Override
                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                        // 设置用户资料
                        for (TIMUserProfile timUserProfile : timUserProfiles) {
                            PendencyEntity data = map.get(timUserProfile.getIdentifier());
                            if (data != null) {
                                data.setUserProfile(timUserProfile);
                                resultData.add(data);
                            }
                        }

                        // 返回结果
                        result.success(JsonUtil.toJSONString(new PendencyPageEntiity(timFriendPendencyResponse, resultData)));
                    }
                });
            }
        });
    }

    /**
     * 腾讯云 未决已读上报
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void pendencyReport(MethodCall methodCall, final Result result) {
        Log.d(TAG, "pendencyReport: ");
        // 已读时间戳，此时间戳以前的消息都将置为已读
        int timestamp = this.getParam(methodCall, result, "timestamp");
        TIMFriendshipManager.getInstance().pendencyReport(timestamp, new VoidCallBack(result));
    }

    /**
     * 腾讯云 未决删除
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deletePendency(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deletePendency: ");
        // 类型
        int type = this.getParam(methodCall, result, "type");

        // 用户Id
        String id = this.getParam(methodCall, result, "id");

        // 删除未决
        TIMFriendshipManager.getInstance().deletePendency(type, Collections.singletonList(id), new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 未决审核
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void examinePendency(MethodCall methodCall, final Result result) {
        Log.d(TAG, "examinePendency: ");
        // 类型
        int type = this.getParam(methodCall, result, "type");
        // 用户Id
        String id = this.getParam(methodCall, result, "id");
        // 好友备注
        String remark = methodCall.argument("remark");

        // 未决审核
        TIMFriendResponse response = new TIMFriendResponse();
        response.setIdentifier(id);
        response.setResponseType(type);
        response.setRemark(remark);
        TIMFriendshipManager.getInstance().doResponse(response, new ValueCallBack<TIMFriendResult>(result));
    }

    /**
     * 腾讯云 删除会话
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteConversation(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteConversation: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        TIMConversationType sessionType = TIMConversationType.valueOf(sessionTypeStr);
        // 删除本地缓存（会话内的消息内容）
        boolean removeCache = this.getParam(methodCall, result, "removeCache");

        boolean res;
        if (removeCache) {
            res = TIMManager.getInstance().deleteConversation(sessionType, sessionId);
        } else {
            res = TIMManager.getInstance().deleteConversationAndLocalMsgs(sessionType, sessionId);
        }
        result.success(res);
    }

    /**
     * 腾讯云 删除会话内的本地聊天记录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteLocalMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteLocalMessage: ");
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");


        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        conversation.deleteLocalMessage(new VoidCallBack(result));
    }

    /**
     * 腾讯云 创建群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void createGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "createGroup: ");
        // 群类型
        String type = this.getParam(methodCall, result, "type");
        // 群名称
        String name = this.getParam(methodCall, result, "name");
        // 群ID
        String groupId = methodCall.argument("groupId");
        // 群公告
        String notification = methodCall.argument("notification");
        // 群简介
        String introduction = methodCall.argument("introduction");
        // 群头像
        String faceUrl = methodCall.argument("faceUrl");
        // 加群选项
        String addOption = methodCall.argument("addOption");
        // 最大群成员数
        Integer maxMemberNum = methodCall.argument("maxMemberNum");
        // 默认群成员
        List<TIMGroupMemberInfo> members = JSON.parseArray(this.getParam(methodCall, result, "members").toString(), TIMGroupMemberInfo.class);

        // 创建参数对象
        TIMGroupManager.CreateGroupParam param = new TIMGroupManager.CreateGroupParam(type, name);
        param.setGroupId(groupId);
        param.setNotification(notification);
        param.setIntroduction(introduction);
        param.setFaceUrl(faceUrl);
        param.setMembers(members);
        param.setAddOption(addOption != null ? TIMGroupAddOpt.valueOf(addOption) : null);
        if (maxMemberNum != null) {
            param.setMaxMemberNum(maxMemberNum);
        }

        // 创建群
        TIMGroupManager.getInstance().createGroup(param, new ValueCallBack<String>(result) {
            @Override
            public void onSuccess(String s) {
                result.success(s);
            }
        });
    }

    /**
     * 腾讯云 邀请加入群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void inviteGroupMember(MethodCall methodCall, final Result result) {
        Log.d(TAG, "inviteGroupMember: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 用户ID集合
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));

        TIMGroupManager.getInstance().inviteGroupMember(groupId, ids, new ValueCallBack<List<TIMGroupMemberResult>>(result));
    }

    /**
     * 腾讯云 申请加入群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void applyJoinGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "applyJoinGroup: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 申请理由
        String reason = methodCall.argument("reason");

        TIMGroupManager.getInstance().applyJoinGroup(groupId, reason, new VoidCallBack(result));
    }

    /**
     * 腾讯云 退出群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void quitGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "quitGroup: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");

        TIMGroupManager.getInstance().quitGroup(groupId, new VoidCallBack(result));
    }

    /**
     * 腾讯云 删除群组成员
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteGroupMember(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteGroupMember: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 用户ID集合
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        // 删除理由
        String reason = methodCall.argument("reason");

        TIMGroupManager.getInstance().deleteGroupMember(new TIMGroupManager.DeleteMemberParam(groupId, ids).setReason(reason), new ValueCallBack<List<TIMGroupMemberResult>>(result));
    }

    /**
     * 腾讯云 获取群成员列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupMembers(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getGroupMembers: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");

        TIMGroupManager.getInstance().getGroupMembers(groupId, new ValueCallBack<List<TIMGroupMemberInfo>>(result) {
            @Override
            public void onSuccess(List<TIMGroupMemberInfo> timGroupMemberInfos) {
                final Map<String, GroupMemberEntity> userInfo = new HashMap<>(timGroupMemberInfos.size(), 1);
                for (TIMGroupMemberInfo timGroupMemberInfo : timGroupMemberInfos) {
                    GroupMemberEntity user = userInfo.get(timGroupMemberInfo.getUser());
                    if (user == null) {
                        user = new GroupMemberEntity(timGroupMemberInfo);
                    }
                    userInfo.put(timGroupMemberInfo.getUser(), user);
                }

                // 获得用户资料
                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
                    @Override
                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                        List<GroupMemberEntity> resultData = new ArrayList<>(userInfo.size());

                        for (TIMUserProfile timUserProfile : timUserProfiles) {
                            GroupMemberEntity entity = userInfo.get(timUserProfile.getIdentifier());
                            if (entity != null) {
                                entity.setUserProfile(timUserProfile);
                            }
                            resultData.add(entity);
                        }
                        result.success(JsonUtil.toJSONString(resultData));
                    }
                });
            }
        });
    }

    /**
     * 腾讯云 解散群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteGroup: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");

        TIMGroupManager.getInstance().deleteGroup(groupId, new VoidCallBack(result));
    }

    /**
     * 腾讯云 转让群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void modifyGroupOwner(MethodCall methodCall, final Result result) {
        Log.d(TAG, "modifyGroupOwner: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 新群主ID
        String identifier = this.getParam(methodCall, result, "identifier");

        TIMGroupManager.getInstance().modifyGroupOwner(groupId, identifier, new VoidCallBack(result));
    }

    /**
     * 腾讯云 修改群资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void modifyGroupInfo(MethodCall methodCall, final Result result) {
        Log.d(TAG, "modifyGroupInfo: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 群名
        String groupName = methodCall.argument("groupName");
        // 公告
        String notification = methodCall.argument("notification");
        // 简介
        String introduction = methodCall.argument("introduction");
        // 群头像
        String faceUrl = methodCall.argument("faceUrl");
        // 加群选项
        String addOption = methodCall.argument("addOption");
        // 最大群成员数
        Integer maxMemberNum = methodCall.argument("maxMemberNum");
        // 是否对外可见
        Boolean visable = methodCall.argument("visable");
        // 全员禁言
        Boolean silenceAll = methodCall.argument("silenceAll");
        // 自定义信息
        String customInfo = methodCall.argument("customInfo");

        TIMGroupManager.ModifyGroupInfoParam param = new TIMGroupManager.ModifyGroupInfoParam(groupId);
        param.setGroupName(groupName);
        param.setNotification(notification);
        param.setIntroduction(introduction);
        param.setFaceUrl(faceUrl);
        param.setAddOption(addOption == null ? null : TIMGroupAddOpt.valueOf(addOption));
        if (maxMemberNum != null) {
            param.setMaxMemberNum(maxMemberNum);
        }
        if (visable != null) {
            param.setVisable(visable);
        }
        if (silenceAll != null) {
            param.setSearchable(silenceAll);
        }
        try {
            if (customInfo != null) {
                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
                for (String s : customInfoData.keySet()) {
                    if (customInfoData.get(s) != null) {
                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
                    }
                }
                param.setCustomInfo(customInfoParams);
            }
        } catch (Exception e) {
            Log.e(TAG, "modifyGroupInfo: set customInfo error", e);
        }
        TIMGroupManager.getInstance().modifyGroupInfo(param, new VoidCallBack(result));
    }

    /**
     * 腾讯云 修改群成员资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void modifyMemberInfo(MethodCall methodCall, final Result result) {
        Log.d(TAG, "modifyMemberInfo: ");
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 群成员ID
        String identifier = this.getParam(methodCall, result, "identifier");
        // 名片
        String nameCard = methodCall.argument("nameCard");
        // 接收消息选项
        String receiveMessageOpt = methodCall.argument("receiveMessageOpt");
        // 禁言时间
        Long silence = methodCall.argument("silence");
        // 角色
        Integer role = methodCall.argument("role");
        // 自定义信息
        String customInfo = methodCall.argument("customInfo");

        TIMGroupManager.ModifyMemberInfoParam param = new TIMGroupManager.ModifyMemberInfoParam(groupId, identifier);
        if (nameCard != null) {
            param.setNameCard(nameCard);
        }
        if (receiveMessageOpt != null) {
            param.setReceiveMessageOpt(TIMGroupReceiveMessageOpt.valueOf(receiveMessageOpt));
        }
        if (silence != null) {
            param.setSilence(silence);
        }
        if (role != null) {
            param.setRoleType(role);
        }
        if (customInfo != null) {
            try {
                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
                for (String s : customInfoData.keySet()) {
                    if (customInfoData.get(s) != null) {
                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
                    }
                }
                param.setCustomInfo(customInfoParams);
            } catch (Exception e) {
                Log.e(TAG, "modifyMemberInfo: set customInfo error", e);
            }
        }
        TIMGroupManager.getInstance().modifyMemberInfo(param, new VoidCallBack(result));
    }

    /**
     * 腾讯云 获得未决群列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupPendencyList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getPendencyList: ");
        // 翻页时间戳，只用来翻页，server 返回0时表示没有更多数据，第一次请求填0
        final int timestamp = methodCall.argument("timestamp");
        // 每页的数量，请求时有效
        int numPerPage = methodCall.argument("numPerPage");

        // 封装请求对象
        TIMGroupPendencyGetParam request = new TIMGroupPendencyGetParam();
        request.setTimestamp(timestamp);
        request.setNumPerPage(numPerPage);

        TIMGroupManager.getInstance().getGroupPendencyList(request, new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
            @Override
            public void onSuccess(final TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
                if (timGroupPendencyListGetSucc.getPendencies().size() == 0) {
                    result.success(JsonUtil.toJSONString(new HashMap<>()));
                    return;
                }

                // 存储ID的集合
                Set<String> groupIds = new HashSet<>();
                Set<String> userIds = new HashSet<>();

                // 返回结果
                final List<GroupPendencyEntity> resultData = new ArrayList<>(timGroupPendencyListGetSucc.getPendencies().size());
                // 循环获得的列表，进行对象封装
                for (TIMGroupPendencyItem item : timGroupPendencyListGetSucc.getPendencies()) {
                    resultData.add(new GroupPendencyEntity(item));
                    groupIds.add(item.getGroupId());
                    userIds.add(item.getIdentifer());
                    userIds.add(item.getToUser());
                }

                // 当前步骤
                final int[] current = {0};

                // 获得群信息
                TIMGroupManager.getInstance().getGroupInfo(Arrays.asList(groupIds.toArray(new String[0])), new ValueCallBack<List<TIMGroupDetailInfoResult>>(result) {
                    @Override
                    public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                        // 循环赋值
                        for (GroupPendencyEntity resultDatum : resultData) {
                            for (TIMGroupDetailInfoResult timGroupDetailInfoResult : timGroupDetailInfoResults) {
                                if (timGroupDetailInfoResult.getGroupId().equals(resultDatum.getGroupId())) {
                                    resultDatum.setGroupInfo(timGroupDetailInfoResult);
                                }
                            }
                        }
                        current[0]++;
                        if (current[0] >= 2) {
                            result.success(JsonUtil.toJSONString(new GroupPendencyPageEntiity(timGroupPendencyListGetSucc.getPendencyMeta(), resultData)));
                        }
                    }
                });

                // 获得用户信息
                TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userIds.toArray(new String[0])), true, new ValueCallBack<List<TIMUserProfile>>(result) {
                    @Override
                    public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                        // 循环赋值
                        for (GroupPendencyEntity resultDatum : resultData) {
                            for (TIMUserProfile timUserProfile : timUserProfiles) {
                                // 申请人信息
                                if (timUserProfile.getIdentifier().equals(resultDatum.getIdentifier())) {
                                    resultDatum.setApplyUserInfo(timUserProfile);
                                }
                                // 处理人信息
                                if (timUserProfile.getIdentifier().equals(resultDatum.getToUser())) {
                                    resultDatum.setHandlerUserInfo(timUserProfile);
                                }
                            }
                        }
                        current[0]++;
                        if (current[0] >= 2) {
                            result.success(JsonUtil.toJSONString(new GroupPendencyPageEntiity(timGroupPendencyListGetSucc.getPendencyMeta(), resultData)));
                        }
                    }
                });
            }
        });
    }

    /**
     * 腾讯云 上报未决已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void reportGroupPendency(MethodCall methodCall, final Result result) {
        Log.d(TAG, "reportGroupPendency: ");
        // 已读时间戳
        Long timestamp = this.getParam(methodCall, result, "timestamp");
        TIMGroupManager.getInstance().reportGroupPendency(timestamp, new VoidCallBack(result));
    }

    /**
     * 腾讯云 同意申请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void groupPendencyAccept(MethodCall methodCall, final Result result) {
        Log.d(TAG, "groupPendencyAccept: ");
        // 理由
        final String msg = methodCall.argument("msg");
        // 群ID
        final String groupId = this.getParam(methodCall, result, "groupId");
        // 申请人ID
        final String identifier = this.getParam(methodCall, result, "identifier");
        // 申请时间
        final long addTime = this.getParam(methodCall, result, "addTime");

        TIMGroupManager.getInstance().getGroupPendencyList(new TIMGroupPendencyGetParam(), new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
            @Override
            public void onSuccess(TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
                List<TIMGroupPendencyItem> data = timGroupPendencyListGetSucc.getPendencies();
                if (data != null) {
                    for (TIMGroupPendencyItem datum : data) {
                        if (datum.getGroupId().equals(groupId) && datum.getIdentifer().equals(identifier) && datum.getAddTime() == addTime) {
                            datum.accept(msg, new VoidCallBack(result));
                            break;
                        }
                    }
                }
            }
        });
    }

    /**
     * 腾讯云 拒绝申请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void groupPendencyRefuse(MethodCall methodCall, final Result result) {
        Log.d(TAG, "groupPendencyAccept: ");
        // 理由
        final String msg = methodCall.argument("msg");
        // 群ID
        final String groupId = this.getParam(methodCall, result, "groupId");
        // 申请人ID
        final String identifier = this.getParam(methodCall, result, "identifier");
        // 申请时间
        final long addTime = this.getParam(methodCall, result, "addTime");

        TIMGroupManager.getInstance().getGroupPendencyList(new TIMGroupPendencyGetParam(), new ValueCallBack<TIMGroupPendencyListGetSucc>(result) {
            @Override
            public void onSuccess(TIMGroupPendencyListGetSucc timGroupPendencyListGetSucc) {
                List<TIMGroupPendencyItem> data = timGroupPendencyListGetSucc.getPendencies();
                if (data != null) {
                    for (TIMGroupPendencyItem datum : data) {
                        if (datum.getGroupId().equals(groupId) && datum.getIdentifer().equals(identifier) && datum.getAddTime() == addTime) {
                            datum.refuse(msg, new VoidCallBack(result));
                            break;
                        }
                    }
                }
            }
        });
    }

    /**
     * 腾讯云 获取自己的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getSelfProfile(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getSelfProfile: ");
        // 强制走后台拉取
        Boolean forceUpdate = methodCall.argument("forceUpdate");
        if (forceUpdate != null && forceUpdate) {
            TIMFriendshipManager.getInstance().getSelfProfile(new ValueCallBack<TIMUserProfile>(result));
        } else {
            // 先获取本地，再获取服务器
            TIMUserProfile data = TIMFriendshipManager.getInstance().querySelfProfile();
            if (data == null) {
                TIMFriendshipManager.getInstance().getSelfProfile(new ValueCallBack<TIMUserProfile>(result));
            } else {
                result.success(JsonUtil.toJSONString(data));
            }
        }
    }

    /**
     * 腾讯云 修改自己的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void modifySelfProfile(MethodCall methodCall, final Result result) {
        Log.d(TAG, "modifySelfProfile: ");

        HashMap params = JSON.parseObject(this.getParam(methodCall, result, "params").toString(), HashMap.class);
        TIMFriendshipManager.getInstance().modifySelfProfile(params, new VoidCallBack(result));
    }

    /**
     * 腾讯云 修改好友的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void modifyFriend(MethodCall methodCall, final Result result) {
        Log.d(TAG, "modifyFriends: ");
        String identifier = this.getParam(methodCall, result, "identifier");
        HashMap params = JSON.parseObject(this.getParam(methodCall, result, "params").toString(), HashMap.class);
        TIMFriendshipManager.getInstance().modifyFriend(identifier, params, new VoidCallBack(result));
    }

    /**
     * 腾讯云 删除好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteFriends(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteFriends: ");
        int delFriendType = this.getParam(methodCall, result, "delFriendType");
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));

        TIMFriendshipManager.getInstance().deleteFriends(ids, delFriendType, new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 添加到黑名单
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void addBlackList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "addBlackList: ");
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        TIMFriendshipManager.getInstance().addBlackList(ids, new ValueCallBack<List<TIMFriendResult>>(result));
    }


    /**
     * 腾讯云 从黑名单删除
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteBlackList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "addBlackList: ");
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        TIMFriendshipManager.getInstance().deleteBlackList(ids, new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 获得黑名单列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getBlackList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getBlackList: ");
        TIMFriendshipManager.getInstance().getBlackList(new ValueCallBack<List<TIMFriend>>(result));
    }

    /**
     * 腾讯云 创建好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void createFriendGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "createFriendGroup: ");
        List<String> groupNames = Arrays.asList(this.getParam(methodCall, result, "groupNames").toString().split(","));
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        TIMFriendshipManager.getInstance().createFriendGroup(groupNames, ids, new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 删除好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteFriendGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteFriendGroup: ");
        List<String> groupNames = Arrays.asList(this.getParam(methodCall, result, "groupNames").toString().split(","));
        TIMFriendshipManager.getInstance().deleteFriendGroup(groupNames, new VoidCallBack(result));
    }

    /**
     * 腾讯云 添加好友到某个分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void addFriendsToFriendGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "addFriendsToFriendGroup: ");
        String groupName = this.getParam(methodCall, result, "groupName");
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        TIMFriendshipManager.getInstance().addFriendsToFriendGroup(groupName, ids, new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 从分组删除好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void deleteFriendsFromFriendGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "deleteFriendsFromFriendGroup: ");
        String groupName = this.getParam(methodCall, result, "groupName");
        List<String> ids = Arrays.asList(this.getParam(methodCall, result, "ids").toString().split(","));
        TIMFriendshipManager.getInstance().deleteFriendsFromFriendGroup(groupName, ids, new ValueCallBack<List<TIMFriendResult>>(result));
    }

    /**
     * 腾讯云 重命名分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void renameFriendGroup(MethodCall methodCall, final Result result) {
        Log.d(TAG, "renameFriendGroup: ");
        String oldGroupName = this.getParam(methodCall, result, "oldGroupName");
        String newGroupName = this.getParam(methodCall, result, "newGroupName");
        TIMFriendshipManager.getInstance().renameFriendGroup(oldGroupName, newGroupName, new VoidCallBack(result));
    }

    /**
     * 腾讯云 获得好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getFriendGroups(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getFriendGroups: ");
        String groupNamesStr = methodCall.argument("groupNames");
        List<String> groupNames = null;
        if (groupNamesStr != null) {
            groupNames = Arrays.asList(groupNamesStr.split(","));
        }
        TIMFriendshipManager.getInstance().getFriendGroups(groupNames, new ValueCallBack<List<TIMFriendGroup>>(result));
    }

    /**
     * 腾讯云 撤回消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void revokeMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "revokeMessage: ");
        // 获得参数
        String sessionId = this.getParam(methodCall, result, "sessionId");
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        long rand = Long.parseLong(this.getParam(methodCall, result, "rand").toString());
        long seq = Long.parseLong(this.getParam(methodCall, result, "seq").toString());
        long timestamp = Long.parseLong(this.getParam(methodCall, result, "timestamp").toString());

        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TIMMessageLocator locator = new TIMMessageLocator();
        locator.setRand(rand);
        locator.setSeq(seq);
        locator.setSelf(true);
        locator.setTimestamp(timestamp);

        // 获得消息
        conversation.findMessages(Collections.singletonList(locator), new ValueCallBack<List<TIMMessage>>(result) {
            @Override
            public void onSuccess(List<TIMMessage> timMessages) {
                // 撤回消息
                conversation.revokeMessage(timMessages.get(0), new VoidCallBack(result));
            }
        });

    }

    /**
     * 腾讯云 删除消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void removeMessage(MethodCall methodCall, final Result result) {
        Log.d(TAG, "removeMessage: ");
        // 获得参数
        String sessionId = this.getParam(methodCall, result, "sessionId");
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        long rand = Long.parseLong(this.getParam(methodCall, result, "rand").toString());
        long seq = Long.parseLong(this.getParam(methodCall, result, "seq").toString());
        long timestamp = Long.parseLong(this.getParam(methodCall, result, "timestamp").toString());
        boolean self = this.getParam(methodCall, result, "self");

        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TIMMessageLocator locator = new TIMMessageLocator();
        locator.setRand(rand);
        locator.setSeq(seq);
        locator.setTimestamp(timestamp);
        locator.setSelf(self);

        // 获得消息
        conversation.findMessages(Collections.singletonList(locator), new ValueCallBack<List<TIMMessage>>(result) {
            @Override
            public void onSuccess(List<TIMMessage> timMessages) {
                result.success(timMessages.get(0).remove());
            }
        });

    }

    /**
     * 腾讯云 设置自定义整型
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setMessageCustomInt(MethodCall methodCall, final Result result) {
        Log.d(TAG, "removeMessage: ");
        // 获得参数
        String sessionId = this.getParam(methodCall, result, "sessionId");
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        long rand = Long.parseLong(this.getParam(methodCall, result, "rand").toString());
        long seq = Long.parseLong(this.getParam(methodCall, result, "seq").toString());
        long timestamp = Long.parseLong(this.getParam(methodCall, result, "timestamp").toString());
        boolean self = this.getParam(methodCall, result, "self");
        final int value = this.getParam(methodCall, result, "value");

        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TIMMessageLocator locator = new TIMMessageLocator();
        locator.setRand(rand);
        locator.setSeq(seq);
        locator.setTimestamp(timestamp);
        locator.setSelf(self);

        // 获得消息
        conversation.findMessages(Collections.singletonList(locator), new ValueCallBack<List<TIMMessage>>(result) {
            @Override
            public void onSuccess(List<TIMMessage> timMessages) {
                timMessages.get(0).setCustomInt(value);
                result.success(null);
            }
        });

    }

    /**
     * 腾讯云 设置自定义字符串
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setMessageCustomStr(MethodCall methodCall, final Result result) {
        Log.d(TAG, "removeMessage: ");
        // 获得参数
        String sessionId = this.getParam(methodCall, result, "sessionId");
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        long rand = Long.parseLong(this.getParam(methodCall, result, "rand").toString());
        long seq = Long.parseLong(this.getParam(methodCall, result, "seq").toString());
        long timestamp = Long.parseLong(this.getParam(methodCall, result, "timestamp").toString());
        boolean self = this.getParam(methodCall, result, "self");
        final String value = this.getParam(methodCall, result, "value");

        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);
        TIMMessageLocator locator = new TIMMessageLocator();
        locator.setRand(rand);
        locator.setSeq(seq);
        locator.setTimestamp(timestamp);
        locator.setSelf(self);

        // 获得消息
        conversation.findMessages(Collections.singletonList(locator), new ValueCallBack<List<TIMMessage>>(result) {
            @Override
            public void onSuccess(List<TIMMessage> timMessages) {
                timMessages.get(0).setCustomStr(value);
                result.success(null);
            }
        });

    }

    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     *
     * @param methodCall 方法调用对象
     * @param result     返回对象
     * @param param      参数名
     */
    private <T> T getParam(MethodCall methodCall, Result result, String param) {
        T par = methodCall.argument(param);
        if (par == null) {
            Log.w(TAG, "init: Cannot find parameter `" + param + "` or `" + param + "` is null!");
            result.error("Missing parameter", "Cannot find parameter `" + param + "` or `" + param + "` is null!", 5);
            throw new RuntimeException("Cannot find parameter `" + param + "` or `" + param + "` is null!");
        }
        return par;
    }
}