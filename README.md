# tencent_im_plugin

腾讯云IM插件

## Getting Started

## Android 端集成

### 1. 修改 defaultConfig ndk 配置
```
defaultConfig {
    .......
    ndk {
        abiFilters "armeabi-v7a"
    }
}
buildTypes {
    release {
        .......
        ndk {
            abiFilters "armeabi-v7a"
        }
    }
    debug {
        .......
        ndk {
            abiFilters "armeabi", "armeabi-v7a", "arm64-v8a", "x86"
        }
    }
}
```
### 2. 设置混淆规则
```
-keep class com.tencent.** { *; }
```

### 3. 如果启动报错，请修改 AndroidManifest.xml 文件
在 manifest 标签上增加:``xmlns:tools="http://schemas.android.com/tools"``
在 application 标签上增加:``tools:replace="android:label"``

## IOS端集成