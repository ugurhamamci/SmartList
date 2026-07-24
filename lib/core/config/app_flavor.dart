/// Build flavors. Selected at compile time via `--dart-define=FLAVOR=...`.
enum AppFlavor {
  development('development'),
  staging('staging'),
  production('production');

  const AppFlavor(this.key);

  final String key;

  static AppFlavor fromKey(String value) {
    return AppFlavor.values.firstWhere(
      (flavor) => flavor.key == value,
      orElse: () => AppFlavor.development,
    );
  }

  bool get isDevelopment => this == AppFlavor.development;
  bool get isStaging => this == AppFlavor.staging;
  bool get isProduction => this == AppFlavor.production;

  /// Suffix appended to the app display name outside production.
  String get displaySuffix => switch (this) {
    AppFlavor.development => ' Dev',
    AppFlavor.staging => ' Staging',
    AppFlavor.production => '',
  };
}
