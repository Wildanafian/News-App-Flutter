import 'package:http/http.dart' as http;
import 'package:news_app_flutter/core/contant/api_constant.dart';

class ApiCall {
  Future<http.Response> fetchNews() {
    return http.get(Uri.parse(ApiConstant.url));
  }
}
