#import "TencentImPlugin.h"
#if __has_include(<tencent_im_plugin/tencent_im_plugin-Swift.h>)
#import <tencent_im_plugin/tencent_im_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tencent_im_plugin-Swift.h"
#endif

@implementation TencentImPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTencentImPlugin registerWithRegistrar:registrar];
}
@end
