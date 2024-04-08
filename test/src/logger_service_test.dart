import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:logger_service/logger_service.dart';

void main() {
  group(
    'LoggerService',
    () {
      test('can be instantiated', () {
        expect(Log(), isNotNull);
        _exampleInvocationsThatShouldNotFail();
      });

      test('can be configured', () {
        Log.tag = 'my-test-app';
        Log.printer = SimplePrinter();
        Log.stacktraceFilters = const [];

        _exampleInvocationsThatShouldNotFail();
      });
    },
    skip: 'this is a visual test only',
  );
}

void _exampleInvocationsThatShouldNotFail() {
  // log with message only
  Log().v('this is a verbose log');
  Log().t('this is a trace log');
  Log().d('this is a debug log');
  Log().i('this is an info log');
  Log().w('this is a warning log');
  Log().e('this is an error log');
  Log().wtf('this is a wtf log');
  Log().f('this is a fatal log');

  // log a real error
  try {
    // ignore: avoid_single_cascade_in_expression_statements
    <String>[]..[2];
  } catch (e, s) {
    Log().w('this is a warning log with a real exception', e);
    Log().e('this is an error log with a real exception and stacktrace', e, s);
  }
}
