import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/listener/ListenerFactory.dart';

/// 加载Dialog
class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog(this.text);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: new Center(
          //保证控件居中效果
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  text != null && text != ''
                      ? new Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: new Text(
                            text,
                            style: new TextStyle(fontSize: 12.0),
                          ),
                        )
                      : new Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 进度条Dialog
class ProgressDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProgressDialogState();
}

class ProgressDialogState extends State<ProgressDialog> {
  /// 进度
  double progress = 0;

  @override
  void initState() {
    super.initState();
    // 绑定收费设置改变监听器
    ListenerFactory.progressDialogChangeNotifier
        .addListener(this.onProgressChangeNotifier);
  }

  @override
  dispose() {
    super.dispose();
    // 移除用户实体改变监听器
    ListenerFactory.progressDialogChangeNotifier
        .removeListener(this.onProgressChangeNotifier);
  }

  /// 上传进度通知
  onProgressChangeNotifier() {
    this.setState(() {
      progress = ListenerFactory.progressDialogChangeNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      //透明类型
      type: MaterialType.transparency,
      //保证控件居中效果
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: Stack(
              children: <Widget>[
                new Container(
                  decoration: ShapeDecoration(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(
                        value: progress,
                        backgroundColor: Color(0xFFCCCCCC),
                        strokeWidth: 1,
                      ),
                      Container(height: 20),
                      Text(
                        "请稍后",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: new FractionalOffset(0.5, 0.31),
                  child: Text(
                    (progress * 100).floor().toString() + "%",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
