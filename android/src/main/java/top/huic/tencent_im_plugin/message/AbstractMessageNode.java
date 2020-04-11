package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;

/**
 * 消息节点接口
 *
 * @param <N> 节点类型，对应腾讯云 TIMElem
 */
public abstract class AbstractMessageNode<N, E extends AbstractMessageEntity> {
    /**
     * 获得发送的消息体
     *
     * @param entity 消息实体
     * @return 结果
     */
    protected abstract TIMMessage getSendMessage(E entity);

    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param onCallback   结果回调
     * @param entity       实体
     * @param ol           是否在线消息
     */
    public void send(TIMConversation conversation, E entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        sendMessage(conversation, getSendMessage(entity), ol, onCallback);
    }

    /**
     * 向本地消息列表中添加一条消息，但并不将其发送出去。
     *
     * @param conversation 会话
     * @param entity       实体
     * @param sender       发送方
     * @param isReaded     是否已读，如果发送方是自己，默认已读
     * @return 消息对象
     */
    public TIMMessage save(TIMConversation conversation, E entity, String sender, Boolean isReaded) {
        return saveMessage(conversation, getSendMessage(entity), sender, isReaded);
    }

    /**
     * 根据消息节点获得描述
     *
     * @param elem 节点
     */
    public abstract String getNote(N elem);

    /**
     * 将节点解析为实体对象
     *
     * @param elem 节点
     * @return 实体对象
     */
    public abstract E analysis(N elem);

    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param ol           是否使用在线消息发送
     * @param onCallback   结果回调
     */
    void sendMessage(TIMConversation conversation, TIMMessage message, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        if (ol) {
            conversation.sendOnlineMessage(message, onCallback);
        } else {
            conversation.sendMessage(message, onCallback);
        }
    }

    /**
     * 向本地消息列表中添加一条消息，但并不将其发送出去。
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param sender       发送方
     * @param isReaded     是否已读，如果发送方是自己，默认已读
     * @return 消息对象
     */
    TIMMessage saveMessage(TIMConversation conversation, TIMMessage message, String sender, Boolean isReaded) {
        conversation.saveMessage(message, sender, isReaded);
        return message;
    }

    /**
     * 获得实体类型
     *
     * @return 类型
     */
    public abstract Class<E> getEntityClass();
}