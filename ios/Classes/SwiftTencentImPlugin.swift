import Flutter
import UIKit
import ImSDK

public class SwiftTencentImPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tencent_im_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftTencentImPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        switch call.method {
        case "init":
            initTencentIm(call: call, result: result)
            break
        case "login":
            login(call: call, result: result)
            break
        case "logout":
            logout(call: call, result: result)
            break
        case "initStorage":
            //            login(call: call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    /**
     * 初始化腾讯云IM
     */
    public func initTencentIm(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let appid = CommonUtils.getParam(call: call, result: result, param: "appid"){
            // 初始化SDK配置
            let sdkConfig = TIMSdkConfig();
            sdkConfig.sdkAppId = (appid as NSString).intValue;
            sdkConfig.logLevel = TIMLogLevel.LOG_WARN;
            //            sdkConfig.logFunc =
            TIMManager.sharedInstance()?.initSdk(sdkConfig);
            
            // 初始化用户配置
            let userConfig = TIMUserConfig();
            userConfig.enableReadReceipt = true;
            TIMManager.sharedInstance()?.setUserConfig(userConfig);
            
            result(nil);
        }
    }
    
    /**
     * 登录
     */
    public func login(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let identifier =  CommonUtils.getParam(call: call, result: result, param: "identifier") ,
            let userSig =  CommonUtils.getParam(call: call, result: result, param: "userSig")
        {
            // 如果已经登录，则不允许重复登录
            if TIMManager.sharedInstance()?.getLoginUser() != nil{
                result(
                    FlutterError(code: "login failed.", message: "user is login", details: "user is already login ,you should login out first")
                );
            }else{
                // 登录操作
                let loginParam = TIMLoginParam();
                loginParam.identifier = identifier;
                loginParam.userSig = userSig;
                //                int code, NSString * msg
                TIMManager.sharedInstance()?.login(loginParam, succ: {
                    result(nil);
                }, fail:CommonUtils.returnErrorClosures(result: result))
            }
        }
    }
    
    /**
     * 登出
     */
    public func logout(call: FlutterMethodCall, result: @escaping FlutterResult){
        TIMManager.sharedInstance()?.logout({
            result(nil);
        },fail:CommonUtils.returnErrorClosures(result: result));
    }
}
