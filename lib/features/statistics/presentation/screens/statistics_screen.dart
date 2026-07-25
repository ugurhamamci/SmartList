import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/completion_bar.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Bir haftanın toplam harcaması.
class WeeklySpend {
  const WeeklySpend({required this.label, required this.amount});

  /// Sütun altındaki kısa etiket ("Pzt", "1. hafta" gibi).
  final String label;
  final double amount;
}

/// Kategori bazlı dağılım dilimi.
class CategoryShare {
  const CategoryShare({
    required this.category,
    required this.itemCount,
    required this.color,
  });

  final String category;
  final int itemCount;
  final Color color;
}

/// İstatistik ekranı: tamamlama oranı, kategori dağılımı ve harcama eğrisi.
///
/// Grafikler `fl_chart` ile çizilir; veri dışarıdan verilir, ekran hesap
/// yapmaz — yalnızca yüzdeleri ve toplamları gösterir.
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    required this.totalItems,
    required this.completedItems,
    required this.activeLists,
    required this.totalSpend,
    required this.currency,
    required this.weeklySpend,
    required this.categories,
    super.key,
  });

  final int totalItems;
  final int completedItems;
  final int activeLists;
  final double totalSpend;
  final String currency;
  final List<WeeklySpend> weeklySpend;
  final List<CategoryShare> categories;

  double get _completionRate =>
      totalItems == 0 ? 0 : completedItems / totalItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Scaffold(
      appBar: AppBar(title: const Text('İstatistikler')),
      body: ListView(
        padding: EdgeInsets.all(spacing.containerMargin),
        children: [
          // --- Özet satırı ---
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  value: '$completedItems/$totalItems',
                  label: 'Alınan ürün',
                  icon: Icons.check_circle_outline,
                  color: scheme.primary,
                ),
              ),
              SizedBox(width: spacing.stackGap),
              Expanded(
                child: _SummaryCard(
                  value: '$activeLists',
                  label: 'Aktif liste',
                  icon: Icons.format_list_bulleted,
                  color: scheme.tertiary,
                ),
              ),
              SizedBox(width: spacing.stackGap),
              Expanded(
                child: _SummaryCard(
                  value: '${totalSpend.toStringAsFixed(0)} $currency',
                  label: 'Tahmini tutar',
                  icon: Icons.payments_outlined,
                  color: scheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing.gutter),

          // --- Tamamlama oranı ---
          SmartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tamamlama oranı',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '%${(_completionRate * 100).round()}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing.stackGap),
                CompletionBar(progress: _completionRate),
              ],
            ),
          ),
          SizedBox(height: spacing.gutter),

          // --- Haftalık harcama ---
          SmartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Haftalık harcama', style: theme.textTheme.titleMedium),
                SizedBox(height: spacing.gutter),
                SizedBox(
                  height: 180,
                  child: weeklySpend.isEmpty
                      ? _emptyChart(context, 'Henüz harcama kaydı yok')
                      : BarChart(_barData(context)),
                ),
              ],
            ),
          ).animate().fadeIn(duration: DesignTokens.durationMedium),
          SizedBox(height: spacing.gutter),

          // --- Kategori dağılımı ---
          SmartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kategori dağılımı', style: theme.textTheme.titleMedium),
                SizedBox(height: spacing.gutter),
                SizedBox(
                  height: 180,
                  child: categories.isEmpty
                      ? _emptyChart(context, 'Kategori verisi yok')
                      : Row(
                          children: [
                            Expanded(
                              child: PieChart(_pieData()),
                            ),
                            SizedBox(width: spacing.gutter),
                            Expanded(child: _legend(context)),
                          ],
                        ),
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: DesignTokens.durationFast,
            duration: DesignTokens.durationMedium,
          ),
        ],
      ),
    );
  }

  Widget _emptyChart(BuildContext context, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        message,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  BarChartData _barData(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Sütunların üstünde nefes payı bırakmak için tavanı %20 yukarı alıyoruz.
    final peak = weeklySpend
        .map((week) => week.amount)
        .reduce((a, b) => a > b ? a : b);

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: peak == 0 ? 1 : peak * 1.2,
      borderData: FlBorderData(show: false),
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: peak == 0 ? 1 : peak / 2,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: scheme.outlineVariant, strokeWidth: 1),
      ),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => scheme.inverseSurface,
          getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(
            '${rod.toY.toStringAsFixed(0)} $currency',
            theme.textTheme.labelMedium!.copyWith(
              color: scheme.onInverseSurface,
            ),
          ),
        ),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        leftTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= weeklySpend.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: DesignTokens.space2),
                child: Text(
                  weeklySpend[index].label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: [
        for (var i = 0; i < weeklySpend.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: weeklySpend[i].amount,
                color: scheme.primary,
                width: 18,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(DesignTokens.radiusDefault),
                ),
              ),
            ],
          ),
      ],
    );
  }

  PieChartData _pieData() {
    final total = categories.fold<int>(
      0,
      (sum, share) => sum + share.itemCount,
    );

    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 34,
      sections: [
        for (final share in categories)
          PieChartSectionData(
            value: share.itemCount.toDouble(),
            color: share.color,
            radius: 28,
            // Dilim içindeki metin küçük dilimlerde okunmuyor; yüzdeyi
            // yalnızca yeterince büyük dilimlerde gösteriyoruz.
            showTitle: total > 0 && share.itemCount / total >= 0.12,
            title: total == 0
                ? ''
                : '%${(share.itemCount / total * 100).round()}',
            titleStyle: const TextStyle(
              fontFamily: DesignTokens.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _legend(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final share in categories)
          Padding(
            padding: const EdgeInsets.only(bottom: DesignTokens.space2),
            child: Row(
              children: [
                Container(
                  width: DesignTokens.space3,
                  height: DesignTokens.space3,
                  decoration: BoxDecoration(
                    color: share.color,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.space1,
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.space2),
                Expanded(
                  child: Text(
                    share.category,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Text(
                  '${share.itemCount}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SmartCard(
      padding: const EdgeInsets.all(DesignTokens.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: DesignTokens.iconSmall),
          const SizedBox(height: DesignTokens.space2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge,
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
