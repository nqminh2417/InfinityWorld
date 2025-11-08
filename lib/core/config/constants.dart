// lib/core/config/constants.dart

/// Một nguồn sự thật cho mọi config.
/// Mặc định dùng DEV. Có thể override bằng --dart-define=KEY=VALUE.
class Cfg {
  // Bật PROD khi build: --dart-define=PROD=true (nếu bạn muốn xài cờ này)
  static const isProd = bool.fromEnvironment('PROD', defaultValue: false);

  // ===== App info =====
  static const appName = String.fromEnvironment('APP_NAME', defaultValue: 'Infinity World (Dev)');

  // ===== API chính =====
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://dev.api.example.com');

  // ===== SMTS =====
  static const smtsBaseUrl = String.fromEnvironment('SMTS_BASE_URL', defaultValue: 'https://summertimesaga.com');

  static const smtsLogoUrl = String.fromEnvironment(
    'SMTS_LOGO_URL',
    defaultValue: 'https://summertimesaga.com/assets/img/logo.png',
  );

  static const smtsProgressUrl = String.fromEnvironment(
    'SMTS_PROGRESS_URL',
    defaultValue: 'https://summertimesaga.com/data/progress.json',
  );

  // (Tuỳ chọn) helper: trả về Uri thay vì String cho code gọi http dễ dùng
  static Uri get apiUri => Uri.parse(apiUrl);
  static Uri get smtsBaseUri => Uri.parse(smtsBaseUrl);
  static Uri get smtsLogoUri => Uri.parse(smtsLogoUrl);
  static Uri get smtsProgressUri => Uri.parse(smtsProgressUrl);
}
