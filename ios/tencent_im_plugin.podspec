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
#   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'

  # 解决 for architecture arm64 问题
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  # 资源导入
  s.vendored_frameworks = '**/*.framework'

  # SDK 依赖
  s.dependency 'TXIMSDK_Plus_iOS_Bitcode', '5.6.1200'

  # alibaba json 序列化库(https://github.com/alibaba/HandyJSON)
  s.dependency 'HandyJSON'
end
