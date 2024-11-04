import 'dart:convert';

import 'package:news_app_flutter/core/network/api_call.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/remote_result.dart';

abstract class TechCrunchRemote {
  Future<RemoteResult<List<Article>>> getLatestNews();
}

class TechCrunchRemoteImpl implements TechCrunchRemote {
  final ApiCall api;

  TechCrunchRemoteImpl({required this.api});

  @override
  Future<RemoteResult<List<Article>>> getLatestNews() async {
    final response = await api.fetchNews();

    final data = NewsResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return SuccessRemote<List<Article>>(data.articles ?? []);
    } else {
      return ErrorRemote(data.message ?? "Service Unavailable");
    }
  }
}
