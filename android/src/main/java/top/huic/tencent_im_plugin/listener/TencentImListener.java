package top.huic.tencent_im_plugin.listener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;
import top.huic.tencent_im_plugin.util.JsonUtil;

/**
 * 腾讯云IM监听器
 *
 * @author 蒋具宏
 */
public class TencentImListener {

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    /**
     * 与Flutter的通信管道
     */
    private static MethodChannel channel;

    /**
     * 初始化监听器管道
     *
     * @param channel 通信管道
     */
    public static void init(MethodChannel channel) {
        TencentImListener.channel = channel;
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
        resultParams.put("params", params == null ? null : JsonUtil.toJSONString(params));
        channel.invokeMethod(LISTENER_FUNC_NAME, JsonUtil.toJSONString(resultParams));
    }
}
