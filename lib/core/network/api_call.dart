import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:news_app_flutter/core/constant/api_constant.dart';

import '../di/main_dependency_injection.dart';

abstract class ApiCall {
  Future<http.Response> fetchNews();
}

class ApiCallImpl implements ApiCall {
  final httpClient = di.get<InterceptedClient>();

  @override
  Future<http.Response> fetchNews() {
    return httpClient.get(Uri.parse(ApiConstant.url));
  }
}
