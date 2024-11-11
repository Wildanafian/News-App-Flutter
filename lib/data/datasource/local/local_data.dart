import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

abstract class LocalSource {
  Future<void> cacheNews(String key, List<NewsItem> newsData);

  Future<List<NewsItem>> getNews(String key);
}

class LocalSourceImpl implements LocalSource {
  final FlutterSecureStorage secureStorage;

  LocalSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheNews(String key, List<NewsItem> newsData) async {
    await secureStorage.write(key: key, value: jsonEncode(newsData));
  }

  @override
  Future<List<NewsItem>> getNews(String key) async {
    final newsDataJson = await secureStorage.read(key: key);
    if (newsDataJson != null) {
      final List<dynamic> newsData = jsonDecode(newsDataJson);
      return newsData.map((item) => NewsItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
