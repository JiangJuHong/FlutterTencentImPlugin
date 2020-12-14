package top.huic.tencent_im_plugin;

import com.tencent.imsdk.v2.V2TIMValueCallback;

import io.flutter.plugin.common.MethodChannel.Result;
import top.huic.tencent_im_plugin.util.JsonUtil;

/**
 * 值改变回调
 *
 * @author 蒋具宏
 */
public class ValueCallBack<T> implements V2TIMValueCallback<T> {
    /**
     * 回调
     */
    private Result result;

    public ValueCallBack(Result result) {
        this.result = result;
    }

    /**
     * 成功事件
     *
     * @param t 结果
     */
    @Override
    public void onSuccess(T t) {
        if (result != null) {
            result.success(JsonUtil.toJSONString(t));
        }
    }


    /**
     * 失败事件
     *
     * @param code 错误码
     * @param desc 错误描述
     */
    @Override
    public void onError(int code, String desc) {
        if (this.result != null) {
            result.error(String.valueOf(code), desc, desc);
        }
    }
}
