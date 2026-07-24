import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/features/shared/presentation/screens/build_status_screen.dart';
import 'package:smartlist/l10n/generated/app_localizations.dart';
import 'package:smartlist/providers/core_providers.dart';

/// Application root.
class SmartListApp extends ConsumerWidget {
  const SmartListApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // themeMode defaults to ThemeMode.system, which is the desired behaviour
      // until the user's stored preference has loaded.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        // Honour the platform text-scale preference, but clamp it so a very
        // large system font cannot make the UI unusable.
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: DesignTokens.minTextScale,
              maxScaleFactor: DesignTokens.maxTextScale,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const BuildStatusScreen(),
    );
  }
}
