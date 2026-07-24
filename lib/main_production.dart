import 'package:smartlist/app.dart';
import 'package:smartlist/core/bootstrap.dart';

/// Production entry point. Run with `--dart-define=FLAVOR=production`.
Future<void> main() => bootstrap(SmartListApp.new);
