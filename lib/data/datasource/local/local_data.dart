import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_app_flutter/core/constant/general_constant.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

abstract class LocalSource {
  Future<void> cacheNews(List<NewsItem> newsData);

  Future<List<NewsItem>> getNews();
}

class LocalSourceImpl implements LocalSource {
  final FlutterSecureStorage secureStorage;

  LocalSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheNews(List<NewsItem> newsData) async {
    await secureStorage.write(
        key: GeneralConst.newsData, value: jsonEncode(newsData));
  }

  @override
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
