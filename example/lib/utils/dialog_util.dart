import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/components/loading_dialog.dart';

/// 对话框工具类
class DialogUtil {
  /// 加载框是否已显示
  static bool loading = false;

  /// 显示Loading
  static showLoading(context, text) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(text);
        });
    loading = true;
  }

  /// 进度loading
  static showProgressLoading(context) {
    showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog();
      },
    );
    loading = true;
  }

  /// 关闭Loading
  static cancelLoading(context) {
    if (loading) {
      Navigator.pop(context);
      loading = false;
    }
  }
}
