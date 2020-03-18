import 'package:flutter/cupertino.dart';

/// 进度改变通知器
class ProgressDialogChangeNotifier extends ValueNotifier<double> {
  ProgressDialogChangeNotifier(double value) : super(value);
}
