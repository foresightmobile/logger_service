import 'package:logger/logger.dart';

/// Customer [PrettyPrinter] that provides the capability to filter
/// the stacktrace
class CustomPrettyPrinter extends PrettyPrinter {
  /// See [LogPrinter]
  CustomPrettyPrinter({
    super.stackTraceBeginIndex,
    super.methodCount,
    super.errorMethodCount,
    super.lineLength,
    super.colors,
    super.printEmojis,
    super.printTime,
    super.excludeBox,
    super.noBoxingByDefault,
    this.stacktraceFilters = const [],
  });

  /// Property to allow the filtering of stacktraces
  final List<RegExp> stacktraceFilters;

  @override
  bool includeStacktraceLine(String line) =>
      super.includeStacktraceLine(line) && !_discardUserStacktraceLine(line);

  bool _discardUserStacktraceLine(String line) =>
      stacktraceFilters.any((element) => element.hasMatch(line));
}
