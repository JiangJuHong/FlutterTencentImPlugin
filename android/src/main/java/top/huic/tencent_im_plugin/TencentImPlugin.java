package top.huic.tencent_im_plugin;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConnListener;
import com.tencent.imsdk.TIMConversation;
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
import com.tencent.imsdk.TIMUserStatusListener;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMMessageRevokedListener;
import com.tencent.imsdk.session.SessionWrapper;
import java.util.List;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * TencentImPlugin
 */
public class TencentImPlugin implements FlutterPlugin, MethodCallHandler {

    /**
     * 日志签名
     */
    public static String TAG = "TencentImPlugin";

    private Context context;

    public TencentImPlugin() {
    }

    public TencentImPlugin(Context context) {
        this.context = context;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tencent_im_plugin");
        channel.setMethodCallHandler(new TencentImPlugin(flutterPluginBinding.getApplicationContext()));
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
        channel.setMethodCallHandler(new TencentImPlugin(registrar.context()));
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
                Log.i(TAG, "initStorage success!");
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
        new GetSessionList().getConversationList(result);
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
//            Log.println(i, TAG + "[" + s + "]", s1);
        }

        /**
         * 被其他终端踢下线
         */
        @Override
        public void onForceOffline() {
            Log.d(TAG, "onForceOffline: ");
        }

        /**
         * 用户签名过期了，需要刷新 userSig 重新登录 IM SDK
         */
        @Override
        public void onUserSigExpired() {
            Log.d(TAG, "onUserSigExpired: ");
        }

        /**
         * 连接监听
         */
        @Override
        public void onConnected() {
            Log.d(TAG, "onConnected: ");
        }

        /**
         * 断开连接监听
         */
        @Override
        public void onDisconnected(int i, String s) {
            Log.d(TAG, "onDisconnected: ");
        }

        /**
         * wifi需要身份认证
         */
        @Override
        public void onWifiNeedAuth(String s) {
            Log.d(TAG, "onWifiNeedAuth: ");
        }

        /**
         * 群消息事件
         */
        @Override
        public void onGroupTipsEvent(TIMGroupTipsElem timGroupTipsElem) {
            Log.d(TAG, "onGroupTipsEvent: ");
        }

        /**
         * 会话刷新
         */
        @Override
        public void onRefresh() {
            Log.d(TAG, "onRefresh: ");
        }

        /**
         * 会话刷新
         */
        @Override
        public void onRefreshConversation(List<TIMConversation> list) {
            Log.d(TAG, "onRefreshConversation: ");
        }

        /**
         * 消息撤回
         */
        @Override
        public void onMessageRevoked(TIMMessageLocator timMessageLocator) {
            Log.d(TAG, "onMessageRevoked: ");
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
            return false;
        }
    }
}
