package top.huic.tencent_im_plugin;

import com.tencent.imsdk.v2.V2TIMCallback;

import io.flutter.plugin.common.MethodChannel;

/**
 * 操作结果回调
 *
 * @author 蒋具宏
 */
public class VoidCallBack implements V2TIMCallback {
    /**
     * 回调
     */
    private MethodChannel.Result result;

    public VoidCallBack(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void onError(int code, String desc) {
        if (result != null) {
            result.error(String.valueOf(code), "Execution Error", desc);
        }
    }

    @Override
    public void onSuccess() {
        if (result != null) {
            result.success(null);
        }
    }
}
