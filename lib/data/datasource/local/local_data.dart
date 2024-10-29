import 'dart:convert';

import 'package:news_app_flutter/core/contant/general_constant.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSource {
  Future<void> cacheNews(List<NewsItem> newsData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(GeneralConst.newsData, jsonEncode(newsData));
  }

  Future<List<NewsItem>> getNews() async {
    final prefs = await SharedPreferences.getInstance();
    final newsDataJson = prefs.getString(GeneralConst.newsData);
    if (newsDataJson != null) {
      final List<dynamic> newsData = jsonDecode(newsDataJson);
      return newsData.map((item) => NewsItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
