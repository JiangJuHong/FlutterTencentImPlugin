package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMMessage;

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
    public V2TIMMessage getV2TIMMessage(E entity) {
        throw new RuntimeException("This node does not support sending");
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
     * 获得实体类型
     *
     * @return 类型
     */
    public abstract Class<E> getEntityClass();
}