enum AppEnv {
  dev,
  prod,
}

class AppConfig {
  const AppConfig({
    required this.env,
    required this.baseApiUrl,
  });

  final AppEnv env;

  final String baseApiUrl;

  static const AppConfig dev = AppConfig(
    env: AppEnv.dev,
    baseApiUrl: "localhost:59201",
  );
}
