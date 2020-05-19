package top.huic.tencent_im_plugin_example.push;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.xiaomi.mipush.sdk.ErrorCode;
import com.xiaomi.mipush.sdk.MiPushClient;
import com.xiaomi.mipush.sdk.MiPushCommandMessage;
import com.xiaomi.mipush.sdk.PushMessageReceiver;

import java.util.List;

import top.huic.tencent_im_plugin_example.MainActivity;

public class XiaomiMsgReceiver extends PushMessageReceiver {

    @Override
    public void onReceiveRegisterResult(Context context, MiPushCommandMessage message) {
        String command = message.getCommand();
        List<String> arguments = message.getCommandArguments();
        String cmdArg1 = ((arguments != null && arguments.size() > 0) ? arguments.get(0) : null);

        String token = null;
        if (MiPushClient.COMMAND_REGISTER.equals(command)) {
            if (message.getResultCode() == ErrorCode.SUCCESS) {
                token = cmdArg1;
            }
        }

        // 调用通知监听器传递到Flutter层
        Handler mainHandler = new Handler(Looper.getMainLooper());
        String finalToken = token;
        mainHandler.post(() -> MainActivity.channel.invokeMethod("miPushTokenListener", finalToken));
    }
}
