/// 日志打印等级
enum LogPrintLevel {
  none,
  debug,
  info,
  warn,
  error,
}

class LogPrintLevelTool {
  /// 将枚举转换为整型
  static int? toInt(LogPrintLevel level) {
    switch (level) {
      case LogPrintLevel.none:
        return 0;
      case LogPrintLevel.debug:
        return 3;
      case LogPrintLevel.info:
        return 4;
      case LogPrintLevel.warn:
        return 5;
      case LogPrintLevel.error:
        return 6;
    }
  }
}
