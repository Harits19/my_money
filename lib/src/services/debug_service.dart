import 'package:logger/web.dart';

final myLog = MyLogger(
  useNativeLog: false,
);

class MyLogger extends Logger {
  final bool useNativeLog;
  final Level? level;

  MyLogger({
    super.filter,
    super.printer,
    super.output,
    this.level,
    required this.useNativeLog,
  }) : super(
          level: useNativeLog ? Level.off : level,
        );

  void nativeLog(dynamic message) {
    if (!useNativeLog || level == Level.off) {
      return;
    }
    print(message);
  }

  @override
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    nativeLog(message);
    log(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }
}
