import ImSDK

//  腾讯云工具类
//  Created by 蒋具宏 on 2020/2/10.
public class TencentImUtils{
    /**
     * 返回[错误返回闭包]，腾讯云IM通用格式
     */
    public static func returnErrorClosures(result: @escaping FlutterResult)->TIMFail{
        return {
            (code : Int32,desc : Optional<String>)-> Void in
            result(
                FlutterError(code: "\(code)",  message: "Execution Error",details: desc!)
            );
        };
    }
    
    /**
     * 获得会话信息
     *
     * @param callback      回调对象
     * @param conversations 原生会话列表
     */
    public static func getConversationInfo(conversations : [TIMConversation]){
        var resultData : [SessionEntity] = [];
        
        if (conversations.count == 0) {
            //            callback.onSuccess(resultData);
            return;
        }
        
        // 需要获取用户信息的列表
        var userInfo = [String: SessionEntity]();
        // 需要获取群信息列表
        var groupInfo = [String: SessionEntity]();
        
        // 根据会话列表封装会话信息
        for timConversation in conversations{
            // 封装会话信息
            let entity = SessionEntity();
            entity.id = timConversation.getReceiver();
            entity.nickname = timConversation.getGroupName();
            entity.type = timConversation.getType();
            entity.unreadMessageNum = timConversation.getUnReadMessageNum();
            
            // 封装获取资料对象
            if timConversation.getType() == TIMConversationType.C2C {
                userInfo[timConversation.getReceiver()] = entity;
            } else if timConversation.getType() == TIMConversationType.GROUP {
                groupInfo[timConversation.getReceiver()] = entity;
            }
            
            // 获取最后一条消息
            let lastMsg = timConversation.getLastMsg();
            if (lastMsg != nil) {
                entity.message = MessageEntity(message: lastMsg!);
            }
            resultData.append(entity);
            
            //            print(userInfo)
            //            print(groupInfo)
        }
    }
    
    /**
     * 根据Message对象获得所有节点
     *
     * @param message 消息对象
     * @return 所有节点对象
     */
    public static func getArrrElement(message : TIMMessage) -> [TIMElem]{
        let elems : [TIMElem] = [];
        for index in 0..<message.elemCount() {
            let elem : TIMElem = message.getElem(index)
            // 语音消息
            if elem is TIMSoundElem{
                
            }
            
            // 文本消息
            if elem is TIMTextElem{
                
            }
        }
        //        for (int i = 0; i < message.getElementCount(); i++) {
        //            TIMElem elem = message.getElement(i);
        //            String rootPath = getSystemFilePath(TencentImPlugin.context);
        //            // 如果是语音，就下载保存
        //            if (elem.getType() == TIMElemType.Sound) {
        //                final TIMSoundElem soundElem = (TIMSoundElem) elem;
        //                final File file = new File(rootPath + "/" + soundElem.getUuid());
        //                if (!file.exists()) {
        //                    // 通知参数
        //                    final Map<String, Object> params = new HashMap<>();
        //                    params.put("type", TIMElemType.Video);
        //                    params.put("uuid", soundElem.getUuid());
        //                    TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadStart, params);
        //
        //                    // 下载
        //                    soundElem.getSoundToFile(file.getPath(), new VoidCallBack(null) {
        //                        @Override
        //                        public void onError(int code, String desc) {
        //                            Log.d(TencentImPlugin.TAG, "login failed. code: " + code + " errmsg: " + desc);
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadFail, params);
        //                        }
        //
        //                        @Override
        //                        public void onSuccess() {
        //                            Log.d(TencentImPlugin.TAG, "download success,path:" + file.getPath());
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadSuccess, params);
        //                        }
        //                    });
        //                }
        //                soundElem.setPath(file.getPath());
        //                // 如果是视频，就保存缩略图
        //            } else if (elem.getType() == TIMElemType.Video) {
        //                final TIMVideoElem videoElem = (TIMVideoElem) elem;
        //                // 缩略图文件
        //                final File snapshotFile = new File(rootPath + "/" + videoElem.getSnapshotInfo().getUuid());
        //                if (!snapshotFile.exists()) {
        //                    // 通知参数
        //                    final Map<String, Object> params = new HashMap<>();
        //                    params.put("type", TIMElemType.Video);
        //                    params.put("uuid", videoElem.getSnapshotInfo().getUuid());
        //                    TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadStart, params);
        //
        //
        //                    // 下载
        //                    videoElem.getSnapshotInfo().getImage(snapshotFile.getPath(), new VoidCallBack(null) {
        //                        @Override
        //                        public void onError(int code, String desc) {
        //                            Log.d(TencentImPlugin.TAG, "login failed. code: " + code + " errmsg: " + desc);
        //                            Map<String, Object> params = new HashMap<>();
        //                            params.put("type", TIMElemType.Video);
        //                            params.put("uuid", videoElem.getSnapshotInfo().getUuid());
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadFail, params);
        //                        }
        //
        //                        @Override
        //                        public void onSuccess() {
        //                            Log.d(TencentImPlugin.TAG, "download success,path:" + snapshotFile.getPath());
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadSuccess, params);
        //                        }
        //                    });
        //                }
        //                videoElem.setSnapshotPath(snapshotFile.getPath());
        //
        //
        //                // 短视频文件
        //                final File videoFile = new File(rootPath + "/" + videoElem.getVideoInfo().getUuid());
        //                if (!videoFile.exists()) {
        //                    // 通知参数
        //                    final Map<String, Object> params = new HashMap<>();
        //                    params.put("type", TIMElemType.Video);
        //                    params.put("uuid", videoElem.getVideoInfo().getUuid());
        //                    TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadStart, params);
        //
        //                    // 下载
        //                    videoElem.getVideoInfo().getVideo(videoFile.getPath(), new VoidCallBack(null) {
        //                        @Override
        //                        public void onError(int code, String desc) {
        //                            Log.d(TencentImPlugin.TAG, "login failed. code: " + code + " errmsg: " + desc);
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadFail, params);
        //                        }
        //
        //                        @Override
        //                        public void onSuccess() {
        //                            Log.d(TencentImPlugin.TAG, "download success,path:" + snapshotFile.getPath());
        //                            TencentImPlugin.invokeListener(ListenerTypeEnum.DownloadSuccess, params);
        //                        }
        //                    });
        //                }
        //                videoElem.setVideoPath(videoFile.getPath());
        //            }
        //            elems.add(elem);
        //        }
        return elems;
    }
}
