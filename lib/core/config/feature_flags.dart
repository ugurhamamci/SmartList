/// Capabilities that can be gated behind a subscription tier.
///
/// Billing is intentionally not implemented; [SubscriptionTier] is resolved
/// from the user document, which only the backend may write. Adding a payment
/// provider later requires no change to call sites.
enum FeatureFlag {
  unlimitedLists('unlimited_lists'),
  unlimitedMembers('unlimited_members'),
  unlimitedAiGenerations('unlimited_ai_generations'),
  advancedStatistics('advanced_statistics'),
  dataExport('data_export'),
  customCategories('custom_categories'),
  voiceInput('voice_input'),
  recipeImport('recipe_import'),
  prioritySupport('priority_support'),
  adFree('ad_free');

  const FeatureFlag(this.key);

  final String key;

  static FeatureFlag? fromKey(String value) {
    for (final flag in FeatureFlag.values) {
      if (flag.key == value) {
        return flag;
      }
    }
    return null;
  }
}

/// Subscription tiers, ordered by capability.
enum SubscriptionTier {
  free('free'),
  plus('plus'),
  family('family');

  const SubscriptionTier(this.key);

  final String key;

  static SubscriptionTier fromKey(String value) {
    return SubscriptionTier.values.firstWhere(
      (tier) => tier.key == value,
      orElse: () => SubscriptionTier.free,
    );
  }

  /// Capabilities granted by this tier.
  Set<FeatureFlag> get entitlements => switch (this) {
    SubscriptionTier.free => const {FeatureFlag.voiceInput},
    SubscriptionTier.plus => const {
      FeatureFlag.unlimitedLists,
      FeatureFlag.unlimitedAiGenerations,
      FeatureFlag.advancedStatistics,
      FeatureFlag.dataExport,
      FeatureFlag.customCategories,
      FeatureFlag.voiceInput,
      FeatureFlag.recipeImport,
      FeatureFlag.adFree,
    },
    SubscriptionTier.family => const {
      FeatureFlag.unlimitedLists,
      FeatureFlag.unlimitedMembers,
      FeatureFlag.unlimitedAiGenerations,
      FeatureFlag.advancedStatistics,
      FeatureFlag.dataExport,
      FeatureFlag.customCategories,
      FeatureFlag.voiceInput,
      FeatureFlag.recipeImport,
      FeatureFlag.prioritySupport,
      FeatureFlag.adFree,
    },
  };

  bool grants(FeatureFlag flag) => entitlements.contains(flag);
}
