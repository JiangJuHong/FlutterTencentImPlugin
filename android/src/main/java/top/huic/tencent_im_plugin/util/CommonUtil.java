package top.huic.tencent_im_plugin.util;

import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 工具类
 */
public class CommonUtil {
    /**
     * 主线程处理器
     */
    private final static Handler MAIN_HANDLER = new Handler(Looper.getMainLooper());

    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     *
     * @param methodCall 方法调用对象
     * @param result     返回对象
     * @param param      参数名
     */
    public static <T> T getParam(MethodCall methodCall, MethodChannel.Result result, String param) {
        T par = methodCall.argument(param);
        if (par == null) {
            result.error("Missing parameter", "Cannot find parameter `" + param + "` or `" + param + "` is null!", 5);
            throw new RuntimeException("Cannot find parameter `" + param + "` or `" + param + "` is null!");
        }
        return par;
    }

    /**
     * 运行主线程返回结果执行
     *
     * @param result 返回结果对象
     * @param param  返回参数
     */
    public static void runMainThreadReturn(final MethodChannel.Result result, final Object param) {
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                result.success(param);
            }
        });
    }

    /**
     * 运行主线程返回错误结果执行
     *
     * @param result       返回结果对象
     * @param errorCode    错误码
     * @param errorMessage 错误信息
     * @param errorDetails 错误内容
     */
    public static void runMainThreadReturnError(final MethodChannel.Result result, final String errorCode, final String errorMessage, final Object errorDetails) {
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                result.error(errorCode, errorMessage, errorDetails);
            }
        });
    }

    /**
     * 运行主线程方法
     */
    public static void runMainThreadMethod(Runnable runnable){
        MAIN_HANDLER.post(runnable);
    }
}
