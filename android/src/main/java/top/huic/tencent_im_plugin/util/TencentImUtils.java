package top.huic.tencent_im_plugin.util;

import com.alibaba.fastjson.JSON;
import com.tencent.imsdk.v2.V2TIMFriendApplication;
import com.tencent.imsdk.v2.V2TIMGroupApplication;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.entity.FindFriendApplicationEntity;
import top.huic.tencent_im_plugin.entity.FindGroupApplicationEntity;
import top.huic.tencent_im_plugin.entity.FindMessageEntity;

/**
 * 腾讯云IM工具类
 */
public class TencentImUtils {

    /**
     * 获得好友申请对象
     *
     * @param json json 字符串
     * @return 获得结果
     */
    public static V2TIMFriendApplication getFriendApplicationByFindGroupApplicationEntity(String json) {
        return getFriendApplicationByFindGroupApplicationEntity(JSON.parseObject(json, FindFriendApplicationEntity.class));
    }

    /**
     * 获得好友申请对象
     *
     * @param data 实体对象
     * @return 获得结果
     */
    public static V2TIMFriendApplication getFriendApplicationByFindGroupApplicationEntity(FindFriendApplicationEntity data) {
        return null;
    }

    /**
     * 获得群申请对象
     *
     * @param json json 字符串
     * @return 获得结果
     */
    public static V2TIMGroupApplication getGroupApplicationByFindGroupApplicationEntity(String json) {
        return getGroupApplicationByFindGroupApplicationEntity(JSON.parseObject(json, FindGroupApplicationEntity.class));
    }

    /**
     * 获得群申请对象
     *
     * @param data 实体对象
     * @return 获得结果
     */
    public static V2TIMGroupApplication getGroupApplicationByFindGroupApplicationEntity(FindGroupApplicationEntity data) {
        return null;
    }

    /**
     * 获得消息对象
     *
     * @param json json字符串
     * @return 获得结果
     */
    public static V2TIMMessage getMessageByFindMessageEntity(String json) {
        return getMessageByFindMessageEntity(JSON.parseObject(json, FindMessageEntity.class));
    }

    /**
     * 获得消息对象
     *
     * @param data 查找消息对象实体
     * @return 获得结果
     */
    public static V2TIMMessage getMessageByFindMessageEntity(FindMessageEntity data) {
        return null;
    }

//    /**
//     * 获得系统目录
//     *
//     * @param context 全局上下文
//     * @return 获得结果
//     */
//    private static String getSystemFilePath(Context context) {
//        String cachePath;
//        if (Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState())
//                || !Environment.isExternalStorageRemovable()) {
//            cachePath = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES).getAbsolutePath();
//        } else {
//            cachePath = context.getFilesDir().getAbsolutePath();
//        }
//        return cachePath;
//    }
}