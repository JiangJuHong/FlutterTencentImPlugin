import Flutter

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
    public static func getParam(call: FlutterMethodCall, result: @escaping FlutterResult, param : String)->Any?
    {
        let value = (call.arguments as! [String:Any])[param];
        if value == nil{
            result(
                FlutterError(code: "5",  message: "Missing parameter",details: "Cannot find parameter `\(param)` or `\(param)` is null!")
            );
        }
        return value
    }
}
