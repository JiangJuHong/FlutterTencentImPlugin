//
//  VideoSnapshotInfo.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/15.
//  视频缩略图信息
public class VideoSnapshotInfo : NSObject{
    /// 图片ID
    var uuid : String?;
    
    /// 宽度
    var width : Int32?;
    
    /// 高度
    var height : Int32?;
    
    /// 大小
    var size : Int32?;
    
    /// 类型
    var type : String?;
    
    /// 路径
    var path : String?;
}
