package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMAdvancedMsgListener;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMMessageReceipt;

import java.util.List;

/**
 * 消息相关监听器
 */
public class CustomAdvancedMsgListener extends V2TIMAdvancedMsgListener {
    /**
     * 新消息通知
     */
    @Override
    public void onRecvNewMessage(V2TIMMessage msg) {
        super.onRecvNewMessage(msg);
    }

    /**
     * C2C已读回执
     */
    @Override
    public void onRecvC2CReadReceipt(List<V2TIMMessageReceipt> receiptList) {
        super.onRecvC2CReadReceipt(receiptList);
    }

    /**
     * 消息撤回
     */
    @Override
    public void onRecvMessageRevoked(String msgID) {
        super.onRecvMessageRevoked(msgID);
    }
}
