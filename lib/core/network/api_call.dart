import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:news_app_flutter/core/constant/api_constant.dart';

abstract class ApiCall {
  Future<http.Response> fetchNews();
}

class ApiCallImpl implements ApiCall {
  final InterceptedClient httpClient;

  ApiCallImpl({required this.httpClient});

  @override
  Future<http.Response> fetchNews() {
    return httpClient.get(Uri.parse(ApiConstant.url));
  }
}
