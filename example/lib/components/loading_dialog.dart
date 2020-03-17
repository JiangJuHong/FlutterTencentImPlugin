import 'package:flutter/material.dart';

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