#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tencent_im_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tencent_im_plugin'
  s.version          = '0.0.1'
  s.summary          = '腾讯云IM插件'
  s.description      = <<-DESC
腾讯云IM插件
                       DESC
  s.homepage         = 'https://github.com/JiangJuHong/FlutterTencentImPlugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'JiangJuHong' => '690717394@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'

  # 资源导入
  s.vendored_frameworks = '**/*.framework'

  # SDK 依赖
  s.dependency 'TXIMSDK_iOS', '5.1.2'

  # alibaba json 序列化库(https://github.com/alibaba/HandyJSON)
  s.dependency 'HandyJSON'
end
