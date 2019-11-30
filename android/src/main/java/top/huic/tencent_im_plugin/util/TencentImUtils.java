package top.huic.tencent_im_plugin.util;

import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMMessage;

import java.util.ArrayList;
import java.util.List;

/**
 * 腾讯云IM工具类
 */
public class TencentImUtils {
    /**
     * 根据Message对象获得所有节点
     *
     * @param message 消息对象
     * @return 所有节点对象
     */
    public static List<TIMElem> getArrrElement(TIMMessage message) {
        List<TIMElem> elems = new ArrayList<>();
        for (int i = 0; i < message.getElementCount(); i++) {
            elems.add(message.getElement(i));
        }
        return elems;
    }
}