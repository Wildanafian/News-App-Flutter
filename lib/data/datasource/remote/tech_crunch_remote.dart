import 'dart:convert';

import 'package:news_app_flutter/core/network/api_call.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/remote_result.dart';

class TechCrunchRemote {
  Future<RemoteResult<List<Article>>> getLatestNews() async {
    ApiCall api = ApiCall();

    final response = await api.fetchNews();

    if (response.statusCode == 200) {
      final data = NewsResponse.fromJson(jsonDecode(response.body));
      return SuccessRemote<List<Article>>(data.articles ?? []);
    } else {
      final data = NewsResponse.fromJson(jsonDecode(response.body));
      return ErrorRemote(data.message ?? "Service Unavailable");
    }
  }
}
