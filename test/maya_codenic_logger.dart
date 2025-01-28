import 'package:codenic_logger/codenic_logger.dart';

class MayaCodenicLogger implements CodenicLogger {
  @override
  String? userId;

  @override
  void close() {}

  @override
  CodenicLogger copyWith(
      {MessageLogPrinter? printer,
      LogFilter? filter,
      LogOutput? output,
      Level? level}) {
    throw UnimplementedError();
  }

  @override
  void debug(MessageLog messageLog, {error, StackTrace? stackTrace}) {}

  @override
  void error(MessageLog messageLog, {error, StackTrace? stackTrace}) {}

  @override
  void fatal(MessageLog messageLog, {error, StackTrace? stackTrace}) {}

  @override
  LogFilter? get filter => throw UnimplementedError();

  @override
  void info(MessageLog messageLog, {error, StackTrace? stackTrace}) {}

  @override
  Level? get level => throw UnimplementedError();

  @override
  LogOutput? get output => throw UnimplementedError();

  @override
  MessageLogPrinter get printer => throw UnimplementedError();

  @override
  void trace(MessageLog messageLog, {error, StackTrace? stackTrace}) {}

  @override
  void warn(MessageLog messageLog, {error, StackTrace? stackTrace}) {}
}
