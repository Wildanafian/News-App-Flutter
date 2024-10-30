import 'package:http/http.dart' as http;
import 'package:news_app_flutter/core/constant/api_constant.dart';

abstract class ApiCall {
  Future<http.Response> fetchNews();
}

class ApiCallImpl implements ApiCall {
  @override
  Future<http.Response> fetchNews() {
    return http.get(Uri.parse(ApiConstant.url));
  }
}
