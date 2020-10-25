package top.huic.tencent_im_plugin;

import android.content.Context;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMElemType;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupAddOpt;
import com.tencent.imsdk.TIMGroupManager;
import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMGroupReceiveMessageOpt;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMOfflinePushSettings;
import com.tencent.imsdk.TIMOfflinePushToken;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.TIMSoundElem;
import com.tencent.imsdk.TIMUserConfig;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMVideoElem;
import com.tencent.imsdk.conversation.ProgressInfo;
import com.tencent.imsdk.ext.group.TIMGroupBaseInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;
import com.tencent.imsdk.ext.group.TIMGroupMemberResult;
import com.tencent.imsdk.ext.group.TIMGroupPendencyGetParam;
import com.tencent.imsdk.ext.group.TIMGroupPendencyItem;
import com.tencent.imsdk.ext.group.TIMGroupPendencyListGetSucc;
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

import java.io.File;
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
import top.huic.tencent_im_plugin.entity.GroupMemberInfo;
import top.huic.tencent_im_plugin.entity.GroupPendencyEntity;
import top.huic.tencent_im_plugin.entity.GroupPendencyPageEntiity;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.PendencyEntity;
import top.huic.tencent_im_plugin.entity.PendencyPageEntiity;
import top.huic.tencent_im_plugin.entity.SessionEntity;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;
import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.listener.TencentImListener;
import top.huic.tencent_im_plugin.message.AbstractMessageNode;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;
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
            case "getConversationList":
                getConversationList(call, result);
                break;
            case "getConversation":
                getConversation(call, result);
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
            case "sendMessage":
                this.sendMessage(call, result);
                break;
            case "saveMessage":
                this.saveMessage(call, result);
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
                break;
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
            case "downloadVideoImage":
                this.downloadVideoImage(call, result);
                break;
            case "downloadVideo":
                this.downloadVideo(call, result);
                break;
            case "downloadSound":
                this.downloadSound(call, result);
                break;
            case "findMessage":
                this.findMessage(call, result);
                break;
            case "setOfflinePushSettings":
                this.setOfflinePushSettings(call, result);
                break;
            case "setOfflinePushToken":
                this.setOfflinePushToken(call, result);
                break;
            default:
                result.notImplemented();
                break;
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
    private void init(MethodCall methodCall, Result result) {
        // 应用appid
        String appid = this.getParam(methodCall, result, "appid");
        Boolean enabledLogPrint = this.getParam(methodCall, result, "enabledLogPrint");
        Integer logPrintLevel = this.getParam(methodCall, result, "logPrintLevel");

        // 主线程才初始化SDK
        if (SessionWrapper.isMainProcess(context)) {
            TencentImListener listener = new TencentImListener(TencentImPlugin.channel);

            // 初始化 SDK
            TIMManager.getInstance().init(context, new TIMSdkConfig(Integer.parseInt(appid))
                    .enableLogPrint(enabledLogPrint)
                    .setLogLevel(logPrintLevel)
            );

            // 基本用户配置
            TIMUserConfig userConfig = new TIMUserConfig()
                    .setUserStatusListener(listener)
                    .setConnectionListener(listener)
                    .setGroupEventListener(listener)
                    .setRefreshListener(listener)
                    .setMessageRevokedListener(listener)
                    .setMessageReceiptListener(listener)
                    .enableReadReceipt(true)
                    .setUploadProgressListener(listener);


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
        String identifier = this.getParam(methodCall, result, "identifier");
        String userSig = this.getParam(methodCall, result, "userSig");

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
        TIMManager.getInstance().logout(new VoidCallBack(result));
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
                if (sessionEntities.size() > 0)
                    result.success(JsonUtil.toJSONString(sessionEntities.get(0)));
                else
                    result.success(null);
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
        this.getMessages(methodCall, result, false);
    }

    /**
     * 腾讯云 获得本地消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLocalMessages(MethodCall methodCall, final Result result) {
        this.getMessages(methodCall, result, true);
    }

    /**
     * 获得消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     * @param local      是否是获取本地消息
     */
    private void getMessages(MethodCall methodCall, final Result result, final boolean local) {
        // 会话IDgetMessage
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        // 消息数量
        final Integer number = this.getParam(methodCall, result, "number");
        // 获得会话信息
        final TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        TencentImUtils.getTimMessage(methodCall, result, "lastMessage", new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                // 获得聊天记录
                if (local) {
                    conversation.getLocalMessage(number, message, new ValueCallBack<List<TIMMessage>>(result) {
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
                    conversation.getMessage(number, message, new ValueCallBack<List<TIMMessage>>(result) {
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
        });
    }

    /**
     * 发送消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void sendMessage(MethodCall methodCall, final Result result) {
        String nodeStr = this.getParam(methodCall, result, "node");
        Map node = JSON.parseObject(nodeStr, Map.class);
        String sessionType = this.getParam(methodCall, result, "sessionType");
        String sessionId = this.getParam(methodCall, result, "sessionId");
        boolean ol = this.getParam(methodCall, result, "ol");

        // 发送消息
        AbstractMessageNode messageNode = MessageNodeType.valueOf(node.get("nodeType").toString()).getMessageNodeInterface();
        AbstractMessageEntity messageEntity = (AbstractMessageEntity) JSON.parseObject(nodeStr, messageNode.getEntityClass());
        messageNode.send(TencentImUtils.getSession(sessionId, sessionType), messageEntity, ol, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                    @Override
                    public void onSuccess(List<MessageEntity> messageEntities) {
                        result.success(JsonUtil.toJSONString(messageEntities.get(0)));
                    }
                });
            }
        });
    }

    /**
     * 发送消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void saveMessage(MethodCall methodCall, final Result result) {
        String nodeStr = this.getParam(methodCall, result, "node");
        Map node = JSON.parseObject(nodeStr, Map.class);
        String sessionType = this.getParam(methodCall, result, "sessionType");
        String sessionId = this.getParam(methodCall, result, "sessionId");
        String sender = this.getParam(methodCall, result, "sender");
        Boolean isReaded = this.getParam(methodCall, result, "isReaded");

        // 发送消息
        AbstractMessageNode messageNode = MessageNodeType.valueOf(node.get("nodeType").toString()).getMessageNodeInterface();
        AbstractMessageEntity messageEntity = (AbstractMessageEntity) JSON.parseObject(nodeStr, messageNode.getEntityClass());
        TIMMessage message = messageNode.save(TencentImUtils.getSession(sessionId, sessionType), messageEntity, sender, isReaded);
        TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
            @Override
            public void onSuccess(List<MessageEntity> messageEntities) {
                result.success(JsonUtil.toJSONString(messageEntities.get(0)));
            }
        });
    }

    /**
     * 腾讯云 获得好友列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getFriendList(MethodCall methodCall, final Result result) {
        TIMFriendshipManager.getInstance().getFriendList(new ValueCallBack<List<TIMFriend>>(result));
    }

    /**
     * 腾讯云 获得群组列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupList(MethodCall methodCall, final Result result) {
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
        // 会话ID
        String sessionId = this.getParam(methodCall, result, "sessionId");
        // 会话类型
        String sessionTypeStr = this.getParam(methodCall, result, "sessionType");
        TIMConversationType sessionType = TIMConversationType.valueOf(sessionTypeStr);
        // 删除本地缓存（会话内的消息内容）
        boolean removeCache = this.getParam(methodCall, result, "removeCache");

        boolean res;
        if (removeCache) {
            res = TIMManager.getInstance().deleteConversationAndLocalMsgs(sessionType, sessionId);
        } else {
            res = TIMManager.getInstance().deleteConversation(sessionType, sessionId);
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
        List<TIMGroupMemberInfo> members = methodCall.argument("members") == null ? new ArrayList() : new ArrayList<TIMGroupMemberInfo>(JSON.parseArray(this.getParam(methodCall, result, "members").toString(), GroupMemberInfo.class));
        // 自定义信息
        String customInfo = methodCall.argument("customInfo");

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
        try {
            if (customInfo != null) {
                Map<String, Object> customInfoData = JSON.parseObject(customInfo);
                Map<String, byte[]> customInfoParams = new HashMap<>(customInfoData.size(), 1);
                for (String s : customInfoData.keySet()) {
                    if (customInfoData.get(s) != null) {
                        customInfoParams.put(s, customInfoData.get(s).toString().getBytes("utf-8"));
                    }
                }
                for (String key : customInfoParams.keySet()) {
                    param.setCustomInfo(key, customInfoParams.get(key));
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "modifyGroupInfo: set customInfo error", e);
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
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 申请理由
        String reason = this.getParam(methodCall, result, "reason");

        TIMGroupManager.getInstance().applyJoinGroup(groupId, reason, new VoidCallBack(result));
    }

    /**
     * 腾讯云 退出群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void quitGroup(MethodCall methodCall, final Result result) {
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
        // 群ID
        String groupId = this.getParam(methodCall, result, "groupId");
        // 群成员ID
        String identifier = this.getParam(methodCall, result, "identifier");
        // 名片
        String nameCard = methodCall.argument("nameCard");
        // 接收消息选项
        String receiveMessageOpt = methodCall.argument("receiveMessageOpt");
        // 禁言时间
        Long silence = null;
        if (methodCall.argument("silence") != null) {
            silence = Long.parseLong(methodCall.argument("silence").toString());
        }
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
        // 翻页时间戳，只用来翻页，server 返回0时表示没有更多数据，第一次请求填0
        Long timestamp = null;
        if (methodCall.argument("timestamp") != null) {
            timestamp = Long.parseLong(methodCall.argument("timestamp").toString());
        }
        // 每页的数量，请求时有效
        Long numPerPage = null;
        if (methodCall.argument("numPerPage") != null) {
            numPerPage = Long.parseLong(methodCall.argument("numPerPage").toString());
        }

        // 封装请求对象
        TIMGroupPendencyGetParam request = new TIMGroupPendencyGetParam();
        if (timestamp != null) {
            request.setTimestamp(timestamp);
        }
        if (numPerPage != null) {
            request.setNumPerPage(numPerPage);
        }

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
        // 已读时间戳
        Long timestamp = Long.parseLong(this.getParam(methodCall, result, "timestamp").toString());
        TIMGroupManager.getInstance().reportGroupPendency(timestamp, new VoidCallBack(result));
    }

    /**
     * 腾讯云 同意申请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void groupPendencyAccept(MethodCall methodCall, final Result result) {
        // 理由
        final String msg = methodCall.argument("msg");
        // 群ID
        final String groupId = this.getParam(methodCall, result, "groupId");
        // 申请人ID
        final String identifier = this.getParam(methodCall, result, "identifier");
        // 申请时间
        final long addTime = Long.parseLong(this.getParam(methodCall, result, "addTime").toString());

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
        // 理由
        final String msg = methodCall.argument("msg");
        // 群ID
        final String groupId = this.getParam(methodCall, result, "groupId");
        // 申请人ID
        final String identifier = this.getParam(methodCall, result, "identifier");
        // 申请时间
        final long addTime = Long.parseLong(this.getParam(methodCall, result, "addTime").toString());

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
        TIMFriendshipManager.getInstance().getBlackList(new ValueCallBack<List<TIMFriend>>(result));
    }

    /**
     * 腾讯云 创建好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void createFriendGroup(MethodCall methodCall, final Result result) {
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
        // 获得消息后撤回
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                message.getConversation().revokeMessage(message, new VoidCallBack(result));

                // 一对一才发送撤回通知(群聊会自动进入撤回监听器)
                if (message.getConversation().getType() == TIMConversationType.C2C) {
                    TencentImListener.invokeListener(ListenerTypeEnum.MessageRevoked, message.getMessageLocator());
                }
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
        // 获得消息后删除
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                result.success(message.remove());
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
        final int value = this.getParam(methodCall, result, "value");
        // 获得消息后设置
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                message.setCustomInt(value);
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
        final String value = this.getParam(methodCall, result, "value");

        // 获得消息后设置
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                message.setCustomStr(value);
                result.success(null);
            }
        });
    }

    /**
     * 腾讯云 获得视频缩略图
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void downloadVideoImage(MethodCall methodCall, final Result result) {
        final String path = methodCall.argument("path");

        // 如果文件存在，则不进行下一步操作
        if (path != null && new File(path).exists()) {
            result.success(path);
            return;
        }

        // 获得消息后设置
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                TIMElem elem = message.getElement(0);
                if (elem.getType() == TIMElemType.Video) {
                    final TIMVideoElem videoElem = (TIMVideoElem) elem;
                    // 如果没有填充目录，则获得临时目录
                    String finalPath = path;
                    if (finalPath == null || "".equals(finalPath)) {
                        finalPath = context.getExternalCacheDir().getPath() + File.separator + videoElem.getSnapshotInfo().getUuid();
                    }

                    // 如果文件存在则不进行下载
                    if (new File(finalPath).exists()) {
                        result.success(finalPath);
                        return;
                    }

                    final String finalPath1 = finalPath;
                    // 获得消息信息
                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                        @Override
                        public void onSuccess(final List<MessageEntity> messageEntities) {
                            // 下载图片
                            videoElem.getSnapshotInfo().getImage(finalPath1, new ValueCallBack<ProgressInfo>(result) {
                                @Override
                                public void onSuccess(ProgressInfo progressInfo) {
                                    Map<String, Object> params = new HashMap<>(3, 1);
                                    params.put("message", messageEntities.get(0));
                                    params.put("path", finalPath1);
                                    params.put("currentSize", progressInfo.getCurrentSize());
                                    params.put("totalSize", progressInfo.getTotalSize());
                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
                                }
                            }, new VoidCallBack(result) {
                                @Override
                                public void onSuccess() {
                                    result.success(finalPath1);
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    /**
     * 腾讯云 下载视频
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void downloadVideo(MethodCall methodCall, final Result result) {
        final String path = methodCall.argument("path");

        // 如果文件存在，则不进行下一步操作
        if (path != null && new File(path).exists()) {
            result.success(path);
            return;
        }

        // 获得消息后设置
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                TIMElem elem = message.getElement(0);
                if (elem.getType() == TIMElemType.Video) {
                    final TIMVideoElem videoElem = (TIMVideoElem) elem;
                    // 如果没有填充目录，则获得临时目录
                    String finalPath = path;
                    if (finalPath == null || "".equals(finalPath)) {
                        finalPath = context.getExternalCacheDir().getPath() + File.separator + videoElem.getVideoInfo().getUuid();
                    }

                    // 如果文件存在则不进行下载
                    if (new File(finalPath).exists()) {
                        result.success(finalPath);
                        return;
                    }

                    final String finalPath1 = finalPath;
                    // 获得消息信息
                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                        @Override
                        public void onSuccess(final List<MessageEntity> messageEntities) {
                            // 下载视频
                            videoElem.getVideoInfo().getVideo(finalPath1, new ValueCallBack<ProgressInfo>(result) {
                                @Override
                                public void onSuccess(ProgressInfo progressInfo) {
                                    Map<String, Object> params = new HashMap<>(3, 1);
                                    params.put("message", messageEntities.get(0));
                                    params.put("path", finalPath1);
                                    params.put("currentSize", progressInfo.getCurrentSize());
                                    params.put("totalSize", progressInfo.getTotalSize());
                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
                                }
                            }, new VoidCallBack(result) {
                                @Override
                                public void onSuccess() {
                                    result.success(finalPath1);
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    /**
     * 腾讯云 下载语音
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void downloadSound(MethodCall methodCall, final Result result) {
        final String path = methodCall.argument("path");

        // 如果文件存在，则不进行下一步操作
        if (path != null && new File(path).exists()) {
            result.success(path);
            return;
        }

        // 获得消息后设置
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(TIMMessage message) {
                TIMElem elem = message.getElement(0);
                if (elem.getType() == TIMElemType.Sound) {
                    final TIMSoundElem soundElem = (TIMSoundElem) elem;
                    // 如果没有填充目录，则获得临时目录
                    String finalPath = path;
                    if (finalPath == null || "".equals(finalPath)) {
                        finalPath = context.getExternalCacheDir().getPath() + File.separator + soundElem.getUuid();
                    }

                    // 如果文件存在则不进行下载
                    if (new File(finalPath).exists()) {
                        result.success(finalPath);
                        return;
                    }

                    final String finalPath1 = finalPath;
                    // 获得消息信息
                    TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result) {
                        @Override
                        public void onSuccess(final List<MessageEntity> messageEntities) {
                            // 下载语音
                            soundElem.getSoundToFile(finalPath1, new ValueCallBack<ProgressInfo>(result) {
                                @Override
                                public void onSuccess(ProgressInfo progressInfo) {
                                    Map<String, Object> params = new HashMap<>(3, 1);
                                    params.put("message", messageEntities.get(0));
                                    params.put("path", finalPath1);
                                    params.put("currentSize", progressInfo.getCurrentSize());
                                    params.put("totalSize", progressInfo.getTotalSize());
                                    TencentImListener.invokeListener(ListenerTypeEnum.DownloadProgress, params);
                                }
                            }, new VoidCallBack(result) {
                                @Override
                                public void onSuccess() {
                                    result.success(finalPath1);
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    /**
     * 腾讯云 查找一条消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void findMessage(MethodCall methodCall, final Result result) {
        TencentImUtils.getTimMessage(methodCall, result, new ValueCallBack<TIMMessage>(result) {
            @Override
            public void onSuccess(final TIMMessage message) {
                TencentImUtils.getMessageInfo(Collections.singletonList(message), new ValueCallBack<List<MessageEntity>>(result));
            }
        });
    }


    /**
     * 腾讯云 设置离线推送设置
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setOfflinePushSettings(MethodCall methodCall, final Result result) {
        TIMOfflinePushSettings settings = new TIMOfflinePushSettings();
        Boolean enabled = methodCall.argument("enabled");
        if (enabled != null) {
            settings.setEnabled(true);
        }
        String c2cSound = methodCall.argument("c2cSound");
        if (c2cSound != null) {
            settings.setC2cMsgRemindSound(Uri.fromFile(new File(c2cSound)));
        }
        String groupSound = methodCall.argument("groupSound");
        if (groupSound != null) {
            settings.setGroupMsgRemindSound(Uri.fromFile(new File(groupSound)));
        }
        String videoSound = methodCall.argument("videoSound");
        if (videoSound != null) {
            settings.setVideoSound(Uri.fromFile(new File(videoSound)));
        }
        TIMManager.getInstance().setOfflinePushSettings(settings);
        result.success(null);
    }

    /**
     * 腾讯云 设置离线推送Token
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void setOfflinePushToken(MethodCall methodCall, final Result result) {
        String token = this.getParam(methodCall, result, "token");
        Long bussid = Long.parseLong(this.getParam(methodCall, result, "bussid").toString());
        TIMManager.getInstance().setOfflinePushToken(new TIMOfflinePushToken(bussid, token), new VoidCallBack(result));
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
            throw new RuntimeException("Cannot find parameter `" + param + "` or `" + param + "` is null!");
        }
        return par;
    }
}