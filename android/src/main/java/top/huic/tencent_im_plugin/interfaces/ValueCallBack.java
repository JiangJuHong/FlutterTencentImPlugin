package top.huic.tencent_im_plugin.interfaces;

/**
 * 值改变回调
 *
 * @author 蒋具宏
 */
public interface ValueCallBack<T> {
    /**
     * 成功事件
     *
     * @param t 结果
     */
    void success(T t);


    /**
     * 失败事件
     *
     * @param code 错误码
     * @param desc 错误描述
     */
    void error(int code, String desc);
}
