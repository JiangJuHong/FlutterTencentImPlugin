import Flutter
import ImSDK

//  通用工具类
//  Created by 蒋具宏 on 2020/2/10.
public class CommonUtils{
    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     *
     * @param methodCall 方法调用对象
     * @param result     返回对象
     * @param param      参数名
     */
    public static func getParam(call: FlutterMethodCall, result: @escaping FlutterResult, param : String)->String?
    {
        let value = (call.arguments as! [String:String])[param]
        if value == nil{
            result(
                FlutterError(code: "5",  message: "Missing parameter",details: "Cannot find parameter `\(param)` or `\(param)` is null!")
            );
        }
        return value
    }
    
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
}
