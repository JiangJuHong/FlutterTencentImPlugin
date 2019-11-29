# tencent_im_plugin

腾讯云IM插件

## Getting Started

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
### 2. 配置权限
```
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### 3. 设置混淆规则
```
-keep class com.tencent.** { *; }
```