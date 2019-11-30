package top.huic.tencent_im_plugin;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConnListener;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupEventListener;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMLogLevel;
import com.tencent.imsdk.TIMLogListener;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMMessageListener;
import com.tencent.imsdk.TIMRefreshListener;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.TIMUserConfig;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMUserStatusListener;
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMMessageRevokedListener;
import com.tencent.imsdk.session.SessionWrapper;

import java.util.ArrayList;
import java.util.Arrays;
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

/**
 * TencentImPlugin
 */
public class TencentImPlugin implements FlutterPlugin, MethodCallHandler {

    /**
     * 日志签名
     */
    static String TAG = "TencentImPlugin";

    /**
     * 全局上下文
     */
    private Context context;

    /**
     * 与Flutter的通信管道
     */
    private MethodChannel channel;

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    public TencentImPlugin() {
    }

    private TencentImPlugin(Context context, MethodChannel channel) {
        this.context = context;
        this.channel = channel;
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
            default:
                Log.w(TAG, "onMethodCall: not found method " + call.method);
                result.notImplemented();
        }
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Log.d(TAG, "onDetachedFromEngine: 123");
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
            // # 禁用本地所有存储
//            userConfig.disableStorage();
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
        new GetSessionList().getConversationInfo(new GetConversationInfoCallback() {
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
    private void invokeListener(ListenerTypeEnum type, Object params) {
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
            new GetSessionList().getConversationInfo(new GetConversationInfoCallback() {
                @Override
                public void success(List<SessionEntity> data) {
                    invokeListener(ListenerTypeEnum.RefreshConversation, null);
                }

                @Override
                public void error(int code, String desc) {
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

            // 需要被获取用户信息的数据集
            final Map<String, MessageEntity> userInfo = new HashMap<>();
            for (TIMMessage timMessage : list) {
                userInfo.put(timMessage.getSender(), new MessageEntity(timMessage));
            }

            // 获取用户资料
            TIMFriendshipManager.getInstance().getUsersProfile(Arrays.asList(userInfo.keySet().toArray(new String[0])), false, new TIMValueCallBack<List<TIMUserProfile>>() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
                }

                @Override
                public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                    // 赋值用户信息并疯转返回集合
                    List<MessageEntity> messageEntities = new ArrayList<>();
                    for (TIMUserProfile timUserProfile : timUserProfiles) {
                        MessageEntity message = userInfo.get(timUserProfile.getIdentifier());
                        if (message != null) {
                            message.setUserInfo(timUserProfile);
                            messageEntities.add(message);
                        }
                    }

                    // 调用回调
                    invokeListener(ListenerTypeEnum.NewMessages, messageEntities);
                }
            });
            return false;
        }
    }
}