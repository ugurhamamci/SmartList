// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SmartList';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonSettings => 'Settings';

  @override
  String get errorNetworkUnavailable =>
      'No internet connection. Changes are saved on this device and will sync automatically.';

  @override
  String get errorNetworkTimeout => 'The request timed out. Please try again.';

  @override
  String get errorServerUnavailable =>
      'SmartList is temporarily unavailable. Please try again shortly.';

  @override
  String get errorPermissionDenied => 'You do not have permission to do that.';

  @override
  String get errorResourceNotFound => 'That item no longer exists.';

  @override
  String get errorResourceConflict =>
      'Someone else changed this at the same time. Your view has been refreshed.';

  @override
  String get errorQuotaRateLimited =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get authInvalidEmail => 'That email address is not valid.';

  @override
  String get authUserDisabled => 'This account has been disabled.';

  @override
  String get authUserNotFound => 'No account exists for that email address.';

  @override
  String get authWrongPassword => 'Incorrect email or password.';

  @override
  String get authInvalidCredential => 'Incorrect email or password.';

  @override
  String get authEmailAlreadyInUse =>
      'An account already exists for that email address.';

  @override
  String get authWeakPassword =>
      'Choose a longer password with at least 8 characters.';

  @override
  String get authRequiresRecentLogin => 'Please sign in again to continue.';

  @override
  String get authUnverifiedEmail => 'Verify your email address to continue.';

  @override
  String get authCancelled => 'Sign-in was cancelled.';

  @override
  String get authFailed => 'Sign-in failed. Please try again.';

  @override
  String get premiumRequired => 'This feature is part of SmartList Plus.';

  @override
  String get aiNoProvider => 'No AI provider is configured in this build.';

  @override
  String get aiRefused => 'The assistant declined this request.';

  @override
  String get aiTruncated =>
      'The response was too long. Try narrowing the request.';

  @override
  String get aiUnparseable =>
      'The assistant returned an unexpected response. Please try again.';

  @override
  String get aiEmptyList =>
      'The assistant did not suggest any items. Try adding more detail.';

  @override
  String get capabilityDenied => 'Permission is required to use this feature.';

  @override
  String get capabilityUnavailable =>
      'This feature is not available on this device.';

  @override
  String get cacheFailure => 'Local data could not be read.';

  @override
  String get validationInvalidArgument =>
      'Some of the information entered is not valid.';
}
