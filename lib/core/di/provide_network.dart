import 'package:news_app_flutter/core/di/main_dependency_injection.dart';
import 'package:news_app_flutter/core/network/api_call.dart';

void provideNetwork() {
  di.registerLazySingleton<ApiCall>(() => ApiCallImpl());
}
