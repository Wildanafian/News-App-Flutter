import 'dart:math';

import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import '../../core/constant/general_constant.dart';
import '../../core/helper/custom_exception.dart';
import '../datasource/local/local_data.dart';
import '../datasource/local/local_hive.dart';
import '../model/ui/consume_result.dart';
import '../model/ui/remote_result.dart';

abstract class TechCrunchRepository {
  Future<ConsumeResult<List<NewsItem>>> getTechNews();

  Future<ConsumeResult<List<NewsItem>>> getEconomyNews();

  Future<NewsItem> getHeadlineNews();
}

class TechCrunchRepositoryImpl implements TechCrunchRepository {
  final TechCrunchRemote remote;
  final LocalSource localPref;
  final LocalBookmark localHive;

  TechCrunchRepositoryImpl(
      {required this.remote, required this.localPref, required this.localHive});

  @override
  Future<ConsumeResult<List<NewsItem>>> getTechNews() async {
    try {
      final result = await remote.getTechLatestNews();
      final bookmarkList = await localHive.getAllBookmarkedNews();

      if (result is SuccessRemote<List<Article>>) {
        List<NewsItem> mappedNews = result.data
            .map((data) => NewsItem(
                title: data.title ?? "",
                content: (data.content ?? "") + (data.description ?? ""),
                imgUrl: data.urlToImage ?? "",
                isBookmarked: _isBookmarked(data.title ?? "", bookmarkList)))
            .toList();
        mappedNews.shuffle();
        localPref.cacheNews(GeneralConst.techData, mappedNews);

        return SuccessConsume<List<NewsItem>>(mappedNews);
      } else {
        final errorResult = result as ErrorRemote<List<Article>>;
        return _defaultError(GeneralConst.techData, errorResult.message);
      }
    } catch (e) {
      return _defaultError(GeneralConst.techData, e.toString());
    }
  }

  @override
  Future<ConsumeResult<List<NewsItem>>> getEconomyNews() async {
    try {
      final result = await remote.getEconomyLatestNews();
      final bookmarkList = await localHive.getAllBookmarkedNews();

      if (result is SuccessRemote<List<Article>>) {
        final mappedNews = result.data
            .map((data) => NewsItem(
                title: data.title ?? "",
                content: (data.content ?? "") + (data.description ?? ""),
                imgUrl: data.urlToImage ?? "",
                isBookmarked: _isBookmarked(data.title ?? "", bookmarkList)))
            .toList();
        mappedNews.shuffle();
        localPref.cacheNews(GeneralConst.economyData, mappedNews);
        return SuccessConsume<List<NewsItem>>(mappedNews);
      } else {
        final errorResult = result as ErrorRemote<List<Article>>;
        return _defaultError(GeneralConst.economyData, errorResult.message);
      }
    } catch (e) {
      return _defaultError(GeneralConst.economyData, e.toString());
    }
  }

  @override
  Future<NewsItem> getHeadlineNews() async {
    final newsSource = [GeneralConst.techData, GeneralConst.economyData];
    final data = await localPref.getNews(newsSource[Random().nextInt(2)]);
    if (data.isEmpty) {
      throw EmptyHeadlineException();
    } else {
      return data[Random().nextInt(9)];
    }
  }

  bool _isBookmarked(String key, List<NewsItem> cache) {
    return cache.any((item) => item.title == key);
  }

  Future<ErrorConsume<List<NewsItem>>> _defaultError(
      String key, String message) async {
    return ErrorConsume<List<NewsItem>>(message, await localPref.getNews(key));
  }
}
