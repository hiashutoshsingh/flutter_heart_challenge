import 'dart:developer' as devtools show log;

extension Log on Object {
  /// just for debugging purposes
  void log() => devtools.log(toString());
}
