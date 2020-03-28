import ImSDK

//
//  GroupTipsMessageself.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群体是消息实体
public class SnsTipsMessageEntity : AbstractMessageEntity{
    /// 未决已读上报时间戳 type == TIMSNSSystemType.TIM_SNS_SYSTEM_PENDENCY_REPORT 时有效
    var pendencyReportTimestamp : UInt64?;
    
    /// 子类型
    var subType : SnsTipsType?;
    
    override init() {
        super.init(MessageNodeType.SnsTips);
    }
    
    init(elem : TIMSNSSystemElem){
        super.init(MessageNodeType.SnsTips);
        self.pendencyReportTimestamp = elem.pendencyReportTimestamp;
        self.subType = SnsTipsType(rawValue: elem.type.rawValue);
    }
}
