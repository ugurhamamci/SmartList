import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/ai/ai_providers.dart';
import 'package:smartlist/providers/core_providers.dart';

/// Reports what this build has configured.
///
/// This is scaffolding, not a designed screen: `tasarim.html` is the specified
/// source of truth for the interface and was empty when the project was set up,
/// so no screen could be built against it. It is deliberately plain — it uses
/// only theme values and adds no visual decisions of its own — and is replaced
/// wholesale by the real navigation shell once the design source is available.
class BuildStatusScreen extends ConsumerWidget {
  const BuildStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final aiProviders = ref.watch(aiServiceProvider).availableProviders;
    final connectivity = ref.watch(isOnlineProvider);
    final spacing = context.spacing;

    return Scaffold(
      appBar: AppBar(title: Text(config.appName)),
      body: ListView(
        padding: EdgeInsets.all(spacing.medium),
        children: [
          Text(
            'Build configuration',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: spacing.small),
          _StatusTile(label: 'Flavor', value: config.flavor.key),
          _StatusTile(
            label: 'Crash reporting',
            value: config.enableCrashlytics ? 'enabled' : 'disabled',
          ),
          _StatusTile(
            label: 'Analytics',
            value: config.enableAnalytics ? 'enabled' : 'disabled',
          ),
          _StatusTile(
            label: 'Offline persistence',
            value: config.enableFirestorePersistence ? 'enabled' : 'disabled',
          ),
          _StatusTile(
            label: 'AI transport',
            value: config.useAiProxy ? 'server-side proxy' : 'direct key',
          ),
          _StatusTile(
            label: 'AI providers',
            value: aiProviders.isEmpty
                ? 'none configured'
                : aiProviders
                      .map((provider) => provider.displayName)
                      .join(', '),
          ),
          _StatusTile(
            label: 'Connectivity',
            value: connectivity.when(
              data: (isOnline) => isOnline ? 'online' : 'offline',
              loading: () => 'checking',
              error: (_, _) => 'unknown',
            ),
          ),
          SizedBox(height: spacing.large),
          Card(
            child: Padding(
              padding: EdgeInsets.all(spacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interface pending',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: spacing.small),
                  const Text(
                    "tasarim.html is the source of truth for this app's "
                    'interface and contained no content, so no screen has been '
                    'built from it. Supply the design file to replace this '
                    'placeholder with the real navigation shell.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(value, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
