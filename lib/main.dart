import 'package:smartlist/app.dart';
import 'package:smartlist/core/bootstrap.dart';

/// Default entry point.
///
/// The flavor is selected by `--dart-define=FLAVOR=...`; `main_development.dart`,
/// `main_staging.dart` and `main_production.dart` exist so a launch
/// configuration can target a flavor without repeating the define.
Future<void> main() => bootstrap(SmartListApp.new);
