package top.huic.tencent_im_plugin_example;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Bundle;
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
        channel = new MethodChannel(this.getFlutterEngine().getDartExecutor(), "tencent_im_plugin_example");
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
