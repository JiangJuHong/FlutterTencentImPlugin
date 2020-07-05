import Flutter

//  通用工具类
//  Created by 蒋具宏 on 2020/2/10.
public class CommonUtils {
    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     *
     * @param methodCall 方法调用对象
     * @param result     返回对象
     * @param param      参数名
     */
    public static func getParam(call: FlutterMethodCall, result: @escaping FlutterResult, param: String) -> Any? {
        let value = (call.arguments as! [String: Any])[param];
        if value == nil {
            result(
                    FlutterError(code: "5", message: "Missing parameter", details: "Cannot find parameter `\(param)` or `\(param)` is null!")
            );
        }
        return value
    }

    /// 将hex string 转为Data
    public static func dataWithHexString(hex: String) -> Data {
        var hex = hex
        var data = Data()
        while (hex.count > 0) {
            let index1 = hex.index(hex.startIndex, offsetBy: 2)
            let index2 = hex.index(hex.endIndex, offsetBy: 0)
            let c: String = String(hex[hex.startIndex..<index1])
            hex = String(hex[index1..<index2])
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            data.append(&char, count: 1)
        }
        return data
    }
}
