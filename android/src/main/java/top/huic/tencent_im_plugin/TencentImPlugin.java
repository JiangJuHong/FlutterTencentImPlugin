package top.huic.tencent_im_plugin;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConnListener;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupEventListener;
import com.tencent.imsdk.TIMGroupManager;
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
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;
import com.tencent.imsdk.ext.group.TIMGroupBaseInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMMessageRevokedListener;
import com.tencent.imsdk.friendship.TIMCheckFriendResult;
import com.tencent.imsdk.friendship.TIMFriend;
import com.tencent.imsdk.friendship.TIMFriendCheckInfo;
import com.tencent.imsdk.friendship.TIMFriendRequest;
import com.tencent.imsdk.friendship.TIMFriendResult;
import com.tencent.imsdk.session.SessionWrapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.SessionEntity;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;
import top.huic.tencent_im_plugin.interfaces.ValueCallBack;
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

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    public TencentImPlugin() {
    }

    private TencentImPlugin(Context context, MethodChannel channel) {
        TencentImPlugin.context = context;
        TencentImPlugin.channel = channel;
        JSON.DEFAULT_GENERATE_FEATURE |= SerializerFeature.DisableCircularReferenceDetect.mask;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
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
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
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
            case "getGroupInfo":
                this.getGroupInfo(call, result);
                break;
            case "getUserInfo":
                this.getUserInfo(call, result);
                break;
            case "getLoginUserInfo":
                this.getLoginUserInfo(call, result);
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
            default:
                Log.w(TAG, "onMethodCall: not found method " + call.method);
                result.notImplemented();
        }
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
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
            TencentImPluginListener listener = new TencentImPluginListener();

            // 初始化 SDK
            TIMManager.getInstance().init(context, new TIMSdkConfig(Integer.parseInt(appid))
                    .enableLogPrint(true)
                    .setLogLevel(TIMLogLevel.WARN)
                    .setLogListener(listener)
            );

            // 基本用户配置
            TIMUserConfig userConfig = new TIMUserConfig()
                    .setUserStatusListener(listener)
                    .setConnectionListener(listener)
                    .setGroupEventListener(listener)
                    .setGroupEventListener(listener)
                    .setRefreshListener(listener)
                    .setMessageRevokedListener(listener);
            // # 开启消息已读回执
            userConfig.enableReadReceipt(true);
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
        TIMManager.getInstance().login(identifier, userSig, new TIMCallBack() {
            @Override
            public void onError(int code, String desc) {
                Log.d(TAG, "login failed. code: " + code + " errmsg: " + desc);
                result.error(desc, String.valueOf(code), null);
            }

            @Override
            public void onSuccess() {
                Log.d(TAG, "login success!");
                result.success(null);
            }
        });
    }

    /**
     * 腾讯云 IM 退出登录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void logout(MethodCall methodCall, final Result result) {
        if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
            TIMManager.getInstance().logout(new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TAG, "logout failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.d(TAG, "logout success!");
                    result.success(null);
                }
            });
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
        TIMManager.getInstance().initStorage(identifier, new TIMCallBack() {
            @Override
            public void onError(int code, String desc) {
                Log.d(TAG, "initStorage failed, code: " + code + "|descr: " + desc);
                result.error(desc, String.valueOf(code), null);
            }

            @Override
            public void onSuccess() {
                Log.d(TAG, "initStorage success!");
                result.success(null);
            }
        });
    }

    /**
     * 腾讯云 获得当前登录用户会话列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getConversationList(MethodCall methodCall, final Result result) {
        new GetSessionList().getConversationInfo(new ValueCallBack<List<SessionEntity>>() {
            @Override
            public void success(List<SessionEntity> data) {
                result.success(JSON.toJSONString(data));
            }

            @Override
            public void error(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }
        }, TIMManager.getInstance().getConversationList());
    }

    /**
     * 腾讯云 获得群信息（先获取本地的，如果本地没有，则获取云端的）
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupInfo(MethodCall methodCall, final Result result) {
        // 群ID
        String id = this.getParam(methodCall, result, "id");
        TIMGroupDetailInfo groupDetailInfo = TIMGroupManager.getInstance().queryGroupInfo(id);
        if (groupDetailInfo == null) {
            TIMGroupManager.getInstance().getGroupInfo(Collections.singletonList(id), new TIMValueCallBack<List<TIMGroupDetailInfoResult>>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(String.valueOf(code), desc, null);
                }

                @Override
                public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                    if (timGroupDetailInfoResults != null && timGroupDetailInfoResults.size() >= 1) {
                        result.success(JSON.toJSONString(timGroupDetailInfoResults.get(0)));
                    } else {
                        result.success(null);
                    }
                }
            });
        } else {
            result.success(JSON.toJSONString(groupDetailInfo));
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
        TIMFriendshipManager.getInstance().getUsersProfile(Collections.singletonList(id), false, new TIMValueCallBack<List<TIMUserProfile>>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                if (timUserProfiles != null && timUserProfiles.size() >= 1) {
                    result.success(JSON.toJSONString(timUserProfiles.get(0)));
                } else {
                    result.success(null);
                }
            }
        });
    }

    /**
     * 腾讯云 获得登录用户信息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getLoginUserInfo(MethodCall methodCall, final Result result) {
        // 用户ID
        String id = TIMManager.getInstance().getLoginUser();
        TIMFriendshipManager.getInstance().getUsersProfile(Collections.singletonList(id), false, new TIMValueCallBack<List<TIMUserProfile>>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                if (timUserProfiles != null && timUserProfiles.size() >= 1) {
                    result.success(JSON.toJSONString(timUserProfiles.get(0)));
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
        conversation.setReadMessage(null, new TIMCallBack() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess() {
                result.success(null);
            }
        });

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
            conversation.getLocalMessage(number, null, new TIMValueCallBack<List<TIMMessage>>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(String.valueOf(code), desc, null);
                }

                @Override
                public void onSuccess(List<TIMMessage> timMessages) {
                    TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>() {
                        @Override
                        public void success(List<MessageEntity> messageEntities) {
                            result.success(JSON.toJSONString(messageEntities));
                        }

                        @Override
                        public void error(int code, String desc) {
                            Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                        }
                    });
                }
            });
        } else {
            conversation.getMessage(number, null, new TIMValueCallBack<List<TIMMessage>>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(String.valueOf(code), desc, null);
                }

                @Override
                public void onSuccess(List<TIMMessage> timMessages) {
                    TencentImUtils.getMessageInfo(timMessages, new ValueCallBack<List<MessageEntity>>() {
                        @Override
                        public void success(List<MessageEntity> messageEntities) {
                            result.success(JSON.toJSONString(messageEntities));
                        }

                        @Override
                        public void error(int code, String desc) {
                            Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                        }
                    });
                }
            });
        }
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
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMTextElem textElem = new TIMTextElem();
        textElem.setText(content);
        message.addElement(textElem);

        // 发送消息
        this.sendMessage(conversation, message, result);
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
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMSoundElem soundElem = new TIMSoundElem();
        soundElem.setPath(path);
        soundElem.setDuration(duration);
        message.addElement(soundElem);

        // 发送消息
        this.sendMessage(conversation, message, result);
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
        // 获得会话信息
        TIMConversation conversation = TencentImUtils.getSession(sessionId, sessionTypeStr);

        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMImageElem imageElem = new TIMImageElem();
        imageElem.setPath(path);
        message.addElement(imageElem);

        // 发送消息
        this.sendMessage(conversation, message, result);
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
        this.sendMessage(conversation, message, result);
    }

    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param result       Flutter返回对象
     */
    private void sendMessage(TIMConversation conversation, TIMMessage message, final Result result) {
        conversation.sendMessage(message, new TIMValueCallBack<TIMMessage>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(TIMMessage message) {
                result.success(null);
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
        Log.d(TAG, "getFriendList: ");
        TIMFriendshipManager.getInstance().getFriendList(new TIMValueCallBack<List<TIMFriend>>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(List<TIMFriend> timFriends) {
                result.success(JSON.toJSONString(timFriends));
            }
        });
    }

    /**
     * 腾讯云 获得群组列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private void getGroupList(MethodCall methodCall, final Result result) {
        Log.d(TAG, "getGroupList: ");
        TIMGroupManager.getInstance().getGroupList(new TIMValueCallBack<List<TIMGroupBaseInfo>>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(List<TIMGroupBaseInfo> groupBaseInfos) {

                List<String> ids = new ArrayList<>(groupBaseInfos.size());
                for (TIMGroupBaseInfo groupBaseInfo : groupBaseInfos) {
                    ids.add(groupBaseInfo.getGroupId());
                }

                // 获得群资料
                TIMGroupManager.getInstance().getGroupInfo(ids, new TIMValueCallBack<List<TIMGroupDetailInfoResult>>() {
                    @Override
                    public void onError(int code, String desc) {
                        result.error(String.valueOf(code), desc, null);
                    }

                    @Override
                    public void onSuccess(List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                        result.success(JSON.toJSONString(timGroupDetailInfoResults));
                    }
                });

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
        TIMFriendshipManager.getInstance().addFriend(request, new TIMValueCallBack<TIMFriendResult>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(TIMFriendResult timFriendResult) {
                result.success(JSON.toJSONString(timFriendResult));
            }
        });
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
        TIMFriendshipManager.getInstance().checkFriends(checkInfo, new TIMValueCallBack<List<TIMCheckFriendResult>>() {
            @Override
            public void onError(int code, String desc) {
                result.error(String.valueOf(code), desc, null);
            }

            @Override
            public void onSuccess(List<TIMCheckFriendResult> timCheckFriendResults) {
                result.success(JSON.toJSONString(timCheckFriendResults.get(0)));
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

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    public static void invokeListener(ListenerTypeEnum type, Object params) {
        Map<String, Object> resultParams = new HashMap<>(2, 1);
        resultParams.put("type", type);
        resultParams.put("params", params == null ? null : JSON.toJSONString(params));
        channel.invokeMethod(LISTENER_FUNC_NAME, JSON.toJSONString(resultParams));
    }

    /**
     * 腾讯云IM监听器
     */
    class TencentImPluginListener implements
            TIMLogListener, TIMUserStatusListener,
            TIMConnListener, TIMGroupEventListener,
            TIMRefreshListener, TIMMessageRevokedListener,
            TIMMessageListener {
        /**
         * 日志监听器
         */
        @Override
        public void log(int i, String s, String s1) {
            Log.println(i, "Tencent Im:[" + s + "]", s1);
        }

        /**
         * 被其他终端踢下线
         */
        @Override
        public void onForceOffline() {
            Log.d(TAG, "onForceOffline: ");
            invokeListener(ListenerTypeEnum.ForceOffline, null);
        }

        /**
         * 用户签名过期了，需要刷新 userSig 重新登录 IM SDK
         */
        @Override
        public void onUserSigExpired() {
            Log.d(TAG, "onUserSigExpired: ");
            invokeListener(ListenerTypeEnum.UserSigExpired, null);
        }

        /**
         * 连接监听
         */
        @Override
        public void onConnected() {
            Log.d(TAG, "onConnected: ");
            invokeListener(ListenerTypeEnum.Connected, null);
        }

        /**
         * 断开连接监听
         */
        @Override
        public void onDisconnected(int i, String s) {
            Log.d(TAG, "onDisconnected: ");
            invokeListener(ListenerTypeEnum.Disconnected, null);
        }

        /**
         * wifi需要身份认证
         */
        @Override
        public void onWifiNeedAuth(String s) {
            Log.d(TAG, "onWifiNeedAuth: ");
            invokeListener(ListenerTypeEnum.WifiNeedAuth, null);
        }

        /**
         * 群消息事件
         */
        @Override
        public void onGroupTipsEvent(TIMGroupTipsElem timGroupTipsElem) {
            Log.d(TAG, "onGroupTipsEvent: ");
            invokeListener(ListenerTypeEnum.GroupTips, null);
        }

        /**
         * 会话刷新
         */
        @Override
        public void onRefresh() {
            Log.d(TAG, "onRefresh: ");
            invokeListener(ListenerTypeEnum.Refresh, null);
        }

        /**
         * 会话刷新
         */
        @Override
        public void onRefreshConversation(List<TIMConversation> list) {
            Log.d(TAG, "onRefreshConversation: ");
            // 获取资料后调用回调
            new GetSessionList().getConversationInfo(new ValueCallBack<List<SessionEntity>>() {
                @Override
                public void success(List<SessionEntity> data) {
                    invokeListener(ListenerTypeEnum.RefreshConversation, data);
                }

                @Override
                public void error(int code, String desc) {
                    Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                }
            }, list);
        }

        /**
         * 消息撤回
         */
        @Override
        public void onMessageRevoked(TIMMessageLocator timMessageLocator) {
            Log.d(TAG, "onMessageRevoked: ");
            invokeListener(ListenerTypeEnum.MessageRevoked, null);
        }

        /**
         * 新消息通知
         *
         * @param list 消息列表
         * @return 默认情况下所有消息监听器都将按添加顺序被回调一次，除非用户在 onNewMessages 回调中返回 true，此时将不再继续回调下一个消息监听器
         */
        @Override
        public boolean onNewMessages(List<TIMMessage> list) {
            Log.d(TAG, "onNewMessages: " + list.toString());
            TencentImUtils.getMessageInfo(list, new ValueCallBack<List<MessageEntity>>() {
                @Override
                public void success(List<MessageEntity> messageEntities) {
                    invokeListener(ListenerTypeEnum.NewMessages, messageEntities);
                }


                @Override
                public void error(int code, String desc) {
                    Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                }
            });
            return false;
        }
    }
}