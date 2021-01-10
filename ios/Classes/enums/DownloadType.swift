//
// Created by 蒋具宏 on 2021/1/5.
//

import Foundation

/// 下载类型
enum DownloadType: Int {
    /// 语音
    case Sound = 0

    /// 视频
    case Video = 1

    /// 视频缩略图
    case VideoThumbnail = 2

    /// 文件
    case File = 3
}
