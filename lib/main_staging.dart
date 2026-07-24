import 'package:smartlist/app.dart';
import 'package:smartlist/core/bootstrap.dart';

/// Staging entry point. Run with `--dart-define=FLAVOR=staging`.
Future<void> main() => bootstrap(SmartListApp.new);
