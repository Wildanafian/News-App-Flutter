import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_app_flutter/core/contant/general_constant.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

class LocalSource {
  final secureStorage = const FlutterSecureStorage();

  Future<void> cacheNews(List<NewsItem> newsData) async {
    await secureStorage.write(
        key: GeneralConst.newsData, value: jsonEncode(newsData));
  }

  Future<List<NewsItem>> getNews() async {
    final newsDataJson = await secureStorage.read(key: GeneralConst.newsData);
    if (newsDataJson != null) {
      final List<dynamic> newsData = jsonDecode(newsDataJson);
      return newsData.map((item) => NewsItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
