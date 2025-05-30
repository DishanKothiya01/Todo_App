import '../../utils/color_print.dart';
import '../../utils/common_enums.dart';

/// A utility class to manage the application's API environment configuration.
class AppEnvironment {
  AppEnvironment._();

  /// Environment type, set in `main.dart`.
  static EnvironmentType environmentType = EnvironmentType.staging;

  // Initial Version.
  static const String initialVersionCode = "v1";

  /// Returns the base URL for the current environment, appending the version code if necessary.
  static String getBaseURL({bool ignoreVersion = false}) {
    printData(key: "APP Environment", value: environmentType.name);

    final String url = _getBaseURLByEnvironment(environmentType);
    return ignoreVersion ? url : "$url/";
  }

  /// Determines the base URL based on the environment type.
  static String _getBaseURLByEnvironment(EnvironmentType env) {
    switch (env) {
      case EnvironmentType.production:
        return "https://ppa-api.happypet.care";

      case EnvironmentType.staging:
        return "http://13.126.213.87:7028";

      case EnvironmentType.development:
        return "";

      case EnvironmentType.local:
        return "http://192.168.29.83:7028";
    }
  }
}
