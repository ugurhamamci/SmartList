import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/home/presentation/screens/search_screen.dart';
import 'package:smartlist/features/profile/presentation/screens/profile_view.dart';
import 'package:smartlist/features/settings/presentation/screens/settings_screen.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/create_list_sheet.dart';
import 'package:smartlist/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:smartlist/features/subscription/presentation/widgets/premium_sheet.dart';

/// Ekranı gerçek tema ve boşluk uzantısıyla sarar; tema uzantısı olmadan
/// `context.spacing` çağrıları düşer, yani sarmalayıcı testin bir parçası.
Widget _host(Widget child) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: child,
  );
}

void main() {
  group('ProfileView', () {
    testWidgets('sayaçları ve ayar satırlarını çizer', (tester) async {
      await tester.pumpWidget(
        _host(
          Scaffold(
            body: ProfileView(
              user: const AvatarData(initials: 'UH', label: 'Uğur'),
              name: 'Uğur Hamamcı',
              email: 'ugur@example.com',
              isPremium: false,
              stats: const [
                ProfileStat(
                  value: '3',
                  label: 'Liste',
                  icon: Icons.list,
                  color: DesignTokens.primary,
                ),
              ],
              onEditProfile: () {},
              onOpenStatistics: () {},
              onOpenSettings: () {},
              onOpenPremium: () {},
              onSignOut: () {},
              versionLabel: 'SmartList 1.0.0',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Uğur Hamamcı'), findsOneWidget);
      expect(find.text('Ücretsiz plan'), findsOneWidget);
      expect(find.text('İstatistikler'), findsOneWidget);

      // Sürüm etiketi listenin en altında; görünür alana kaydırmak gerekiyor.
      await tester.scrollUntilVisible(find.text('SmartList 1.0.0'), 200);
      expect(find.text('SmartList 1.0.0'), findsOneWidget);
    });

    testWidgets('ayarlar satırına dokunmak geri çağrıyı tetikler', (
      tester,
    ) async {
      var opened = 0;

      await tester.pumpWidget(
        _host(
          Scaffold(
            body: ProfileView(
              user: const AvatarData(initials: 'UH'),
              name: 'Uğur',
              email: 'ugur@example.com',
              isPremium: true,
              stats: const [],
              onEditProfile: () {},
              onOpenStatistics: () {},
              onOpenSettings: () => opened++,
              onOpenPremium: () {},
              onSignOut: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Uygulama ayarları'));
      await tester.pumpAndSettle();

      expect(opened, 1);
      // Premium üyede satır metni değişir.
      expect(find.text('Aboneliğim'), findsOneWidget);
    });
  });

  group('SettingsScreen', () {
    testWidgets('anahtar çevirmek yeni ayar nesnesi bildirir', (tester) async {
      AppSettings? latest;

      await tester.pumpWidget(
        _host(
          SettingsScreen(
            settings: const AppSettings(),
            onChanged: (value) => latest = value,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Günlük e-posta özeti'));
      await tester.pumpAndSettle();

      expect(latest, isNotNull);
      expect(latest!.activityEmails, isTrue);
      // Diğer alanlar korunmalı.
      expect(latest!.pushEnabled, isTrue);
      expect(latest!.currency, 'TRY');
    });

    testWidgets('tema seçimi bildirilir', (tester) async {
      AppSettings? latest;

      await tester.pumpWidget(
        _host(
          SettingsScreen(
            settings: const AppSettings(),
            onChanged: (value) => latest = value,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Koyu'));
      await tester.pumpAndSettle();

      expect(latest?.themeMode, ThemeMode.dark);
    });
  });

  group('StatisticsScreen', () {
    testWidgets('özet, oran ve grafikler çizilir', (tester) async {
      await tester.pumpWidget(
        _host(
          const StatisticsScreen(
            totalItems: 8,
            completedItems: 2,
            activeLists: 2,
            totalSpend: 256,
            currency: 'TRY',
            weeklySpend: [
              WeeklySpend(label: 'Pzt', amount: 40),
              WeeklySpend(label: 'Sal', amount: 90),
            ],
            categories: [
              CategoryShare(
                category: 'Market',
                itemCount: 5,
                color: DesignTokens.primary,
              ),
              CategoryShare(
                category: 'Manav',
                itemCount: 3,
                color: DesignTokens.secondary,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2/8'), findsOneWidget);
      expect(find.text('%25'), findsOneWidget);
      expect(find.text('Market'), findsOneWidget);
    });

    testWidgets('veri yoksa sıfıra bölmeden boş durum gösterir', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          const StatisticsScreen(
            totalItems: 0,
            completedItems: 0,
            activeLists: 0,
            totalSpend: 0,
            currency: 'TRY',
            weeklySpend: [],
            categories: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('%0'), findsOneWidget);
      expect(find.text('Henüz harcama kaydı yok'), findsOneWidget);
      expect(find.text('Kategori verisi yok'), findsOneWidget);
    });
  });

  group('PremiumSheet', () {
    testWidgets('yıllık plan öntanımlı seçili ve plan değiştirilebilir', (
      tester,
    ) async {
      String? purchased;

      await tester.pumpWidget(
        _host(
          Scaffold(
            body: PremiumSheet(onPurchase: (plan) => purchased = plan),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yıllık planla başla'), findsOneWidget);

      // Sayfa test görüntü alanından uzun; dokunmadan önce görünür alana
      // kaydırmak gerekiyor.
      await tester.ensureVisible(find.text('Aylık'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aylık'));
      await tester.pumpAndSettle();
      expect(find.text('Aylık planla başla'), findsOneWidget);

      await tester.ensureVisible(find.text('Aylık planla başla'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aylık planla başla'));
      await tester.pumpAndSettle();
      expect(purchased, 'monthly');
    });
  });

  group('SearchScreen', () {
    testWidgets('tek karakterde arama yapmaz, ikiden sonra sonuç gösterir', (
      tester,
    ) async {
      final queries = <String>[];

      await tester.pumpWidget(
        _host(
          SearchScreen(
            recentQueries: const ['süt'],
            onSearch: (query) {
              queries.add(query);
              return const [
                SearchHit(
                  listId: '1',
                  title: 'Haftalık Market',
                  subtitle: '6 ürün',
                  isList: true,
                ),
              ];
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Sorgu boşken son aramalar görünür.
      expect(find.text('SON ARAMALAR'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'm');
      await tester.pumpAndSettle();
      expect(queries, isEmpty);

      await tester.enterText(find.byType(TextField), 'ma');
      await tester.pumpAndSettle();
      expect(queries, ['ma']);
      expect(find.text('Haftalık Market'), findsOneWidget);
    });

    testWidgets('sonuç yoksa boş durum gösterir', (tester) async {
      await tester.pumpWidget(
        _host(SearchScreen(onSearch: (_) => const [])),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('Sonuç bulunamadı'), findsOneWidget);
    });
  });

  group('CreateListSheet', () {
    testWidgets('boş başlıkla oluşturulamaz, ad girilince oluşur', (
      tester,
    ) async {
      NewList? created;

      await tester.pumpWidget(
        _host(
          Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  created = await CreateListSheet.show(context);
                },
                child: const Text('aç'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('aç'));
      await tester.pumpAndSettle();

      // Başlık boşken oluşturma düğmesi sonuç döndürmemeli.
      final createButton = find.widgetWithText(FilledButton, 'Listeyi Oluştur');
      expect(createButton, findsOneWidget);
      await tester.tap(createButton);
      await tester.pumpAndSettle();
      expect(created, isNull);

      await tester.enterText(find.byType(TextField).first, 'Piknik');
      await tester.pumpAndSettle();
      await tester.tap(createButton);
      await tester.pumpAndSettle();

      expect(created, isNotNull);
      expect(created!.title, 'Piknik');
    });
  });
}
