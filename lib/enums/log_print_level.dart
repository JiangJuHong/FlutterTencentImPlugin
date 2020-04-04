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
  static int toInt(LogPrintLevel level) {
    switch (level) {
      case LogPrintLevel.none:
        return 0;
        break;
      case LogPrintLevel.debug:
        return 3;
        break;
      case LogPrintLevel.info:
        return 4;
        break;
      case LogPrintLevel.warn:
        return 5;
        break;
      case LogPrintLevel.error:
        return 6;
        break;
    }
    return null;
  }
}
