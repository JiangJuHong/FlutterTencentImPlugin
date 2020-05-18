package top.huic.tencent_im_plugin_example;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Bundle;

import com.xiaomi.mipush.sdk.MiPushClient;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    /**
     * Flutter 通知器
     */
    public static MethodChannel channel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (shouldInit()) {
            MiPushClient.registerPush(this, "2882303761518400514", "5241840023514");
        }
        channel = new MethodChannel(this.getFlutterEngine().getDartExecutor(), "tencent_im_plugin_example");
    }

    /**
     * 通过判断手机里的所有进程是否有这个App的进程
     * 从而判断该App是否有打开
     *
     * @return 是否需要初始化 -true 需要
     */
    private boolean shouldInit() {
        // 通过ActivityManager我们可以获得系统里正在运行的activities
        // 包括进程(Process)等、应用程序/包、服务(Service)、任务(Task)信息。
        ActivityManager am = ((ActivityManager) getSystemService(Context.ACTIVITY_SERVICE));
        List<ActivityManager.RunningAppProcessInfo> processInfos = am.getRunningAppProcesses();
        String mainProcessName = getPackageName();

        // 获取本App的唯一标识
        int myPid = android.os.Process.myPid();
        // 利用一个增强for循环取出手机里的所有进程
        for (ActivityManager.RunningAppProcessInfo info : processInfos) {
            // 通过比较进程的唯一标识和包名判断进程里是否存在该App
            if (info.pid == myPid && mainProcessName.equals(info.processName)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
