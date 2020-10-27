package top.huic.tencent_im_plugin.enums;

import com.tencent.imsdk.v2.V2TIMElem;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.AbstractMessageNode;
import top.huic.tencent_im_plugin.message.CustomMessageNode;
import top.huic.tencent_im_plugin.message.FaceMessageNode;
import top.huic.tencent_im_plugin.message.FileMessageNode;
import top.huic.tencent_im_plugin.message.GroupTipsMessageNode;
import top.huic.tencent_im_plugin.message.ImageMessageNode;
import top.huic.tencent_im_plugin.message.LocationMessageNode;
import top.huic.tencent_im_plugin.message.SoundMessageNode;
import top.huic.tencent_im_plugin.message.TextMessageNode;
import top.huic.tencent_im_plugin.message.VideoMessageNode;

/**
 * 消息节点类型
 *
 * @author 蒋具宏
 */
public enum MessageNodeType {
    /**
     * 没有元素
     */
    None(null) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return null;
        }
    },

    /**
     * 文本
     */
    Text(new TextMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getTextElem();
        }
    },

    /**
     * 自定义
     */
    Custom(new CustomMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getCustomElem();
        }
    },

    /**
     * 图片
     */
    Image(new ImageMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getImageElem();
        }
    },

    /**
     * 语音
     */
    Sound(new SoundMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getSoundElem();
        }
    },

    /**
     * 视频
     */
    Video(new VideoMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getVideoElem();
        }
    },

    /**
     * 文件
     */
    File(new FileMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getFileElem();
        }
    },

    /**
     * 位置
     */
    Location(new LocationMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getLocationElem();
        }
    },

    /**
     * 表情
     */
    Face(new FaceMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getFaceElem();
        }
    },

    /**
     * 群提示
     */
    GroupTips(new GroupTipsMessageNode()) {
        @Override
        public V2TIMElem getElemByMessage(V2TIMMessage message) {
            return message.getGroupTipsElem();
        }
    };

    /**
     * 消息节点接口
     * 通过枚举的方法反向绑定接口，和业务强关联
     */
    private AbstractMessageNode messageNodeInterface;

    MessageNodeType(AbstractMessageNode messageNodeInterface) {
        this.messageNodeInterface = messageNodeInterface;
    }

    /**
     * 获得消息节点接口
     */
    public AbstractMessageNode getMessageNodeInterface() {
        return messageNodeInterface;
    }

    /**
     * 根据Message获得节点信息
     *
     * @param message 消息对象
     * @return 节点对象
     */
    public abstract V2TIMElem getElemByMessage(V2TIMMessage message);

    /**
     * 根据TIM V2版本的常量进行获取
     *
     * @param constant 常量值
     * @return 结果
     */
    public static MessageNodeType getMessageNodeTypeByV2TIMConstant(int constant) {
        return MessageNodeType.values()[constant];
    }
}