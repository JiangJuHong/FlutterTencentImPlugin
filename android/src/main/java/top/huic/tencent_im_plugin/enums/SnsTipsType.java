package top.huic.tencent_im_plugin.enums;

/**
 * 关系链相关操作类型
 *
 * @author 蒋具宏
 */
public enum SnsTipsType {
    /**
     * 未知
     */
    INVALID(0),
    /**
     * 增加好友消息
     */
    ADD_FRIEND(1),
    /**
     * 删除好友
     */
    DEL_FRIEND(2),
    /**
     * 增加好友申请
     */
    ADD_FRIEND_REQ(3),
    /**
     * 删除好友申请
     */
    DEL_FRIEND_REQ(4),
    /**
     * 添加黑名单
     */
    ADD_BLACKLIST(5),
    /**
     * 删除黑名单
     */
    DEL_BLACKLIST(6),
    /**
     * 未决已读上报
     */
    PENDENCY_REPORT(7),
    /**
     * 关系链资料变更
     */
    SNS_PROFILE_CHANGE(8),
    /**
     * 推荐数据增加
     */
    ADD_RECOMMEND(9),
    /**
     * 推荐数据减少
     */
    DEL_RECOMMEND(10),
    /**
     * 已决增加
     */
    ADD_DECIDE(11),
    /**
     * 已决减少
     */
    DEL_DECIDE(12),
    /**
     * 推荐已读上报
     */
    RECOMMEND_REPORT(13),
    /**
     * 已决已读上报
     */
    DECIDE_REPORT(14);

    /**
     * 值
     */
    private int value;

    SnsTipsType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    /**
     * 根据值获得枚举
     *
     * @param value 值
     * @return 返回结果
     */
    public static SnsTipsType getSnsTipsTypeByValue(int value) {
        for (SnsTipsType snsTipsType : SnsTipsType.values()) {
            if (snsTipsType.getValue() == value) {
                return snsTipsType;
            }
        }

        return null;
    }
}
