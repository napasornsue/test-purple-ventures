enum EnvironmentType { Production, Staging }

class AppConfig {
  static EnvironmentType ENVIRONMENT = EnvironmentType.Staging;
  static String APP_NAME = "Test Purple Ventures";
  static String VERSION_NAME = "1.0.0";
  static String BUILD_NUMBER = "1";
  static bool SHOW_PASSCODE = false;

  static bool get IS_PRODUCTION => checkTargets(
    staging: false,
    production: true,
  );

  static String get SERVICE_ENDPOINT => checkTargets(
    staging: "https://todo-list-api-mfchjooefq-as.a.run.app",
    production: "",
  );

  static bool get IS_DEBUG_MODE => checkTargets(
    staging: true,
    production: false, //remove ! for production release
  );

  static dynamic checkTargets({required dynamic staging, required dynamic production}) => (ENVIRONMENT == EnvironmentType.Production) ? production : staging;
}