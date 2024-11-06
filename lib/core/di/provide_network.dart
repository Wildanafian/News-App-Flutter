import 'package:http_interceptor/http_interceptor.dart';
import 'package:news_app_flutter/core/di/main_dependency_injection.dart';
import 'package:news_app_flutter/core/network/api_call.dart';

import '../network/interceptor.dart';

void provideNetwork() {
  di.registerLazySingleton<InterceptedClient>(() => InterceptedClient.build(
        interceptors: [LoggerInterceptor()],
        requestTimeout: const Duration(seconds: 30),
      ));
  di.registerLazySingleton<ApiCall>(
      () => ApiCallImpl(httpClient: di<InterceptedClient>()));
}
