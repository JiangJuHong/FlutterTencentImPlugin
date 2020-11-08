package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMAdvancedMsgListener;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMMessageReceipt;

import java.util.List;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.entity.CustomMessageEntity;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

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
        TencentImPlugin.invokeListener(ListenerTypeEnum.NewMessage, new CustomMessageEntity(msg));
    }

    /**
     * C2C已读回执
     */
    @Override
    public void onRecvC2CReadReceipt(List<V2TIMMessageReceipt> receiptList) {
        super.onRecvC2CReadReceipt(receiptList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.C2CReadReceipt, receiptList);
    }

    /**
     * 消息撤回
     */
    @Override
    public void onRecvMessageRevoked(String msgID) {
        super.onRecvMessageRevoked(msgID);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MessageRevoked, msgID);
    }
}
