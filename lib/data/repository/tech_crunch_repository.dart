import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import '../datasource/local/local_data.dart';
import '../datasource/local/local_hive.dart';
import '../model/ui/consume_result.dart';
import '../model/ui/remote_result.dart';

abstract class TechCrunchRepository {
  Future<ConsumeResult<List<NewsItem>>> getLatestNews();

  Future<NewsItem> getHeadlineNews();
}

class TechCrunchRepositoryImpl implements TechCrunchRepository {
  final TechCrunchRemote remote;
  final LocalSource localPref;
  final LocalBookmark localHive;

  TechCrunchRepositoryImpl(
      {required this.remote, required this.localPref, required this.localHive});

  @override
  Future<ConsumeResult<List<NewsItem>>> getLatestNews() async {
    try {
      final result = await remote.getLatestNews();
      final bookmarkList = await localHive.getAllBookmarkedNews();

      if (result is SuccessRemote<List<Article>>) {
        final mappedNews = result.data
            .map((data) => NewsItem(
                title: data.title,
                content: data.content + data.description,
                imgUrl: data.urlToImage,
                isBookmarked: _isBookmarked(data.title, bookmarkList)))
            .toList();
        localPref.cacheNews(mappedNews);

        return SuccessConsume<List<NewsItem>>(mappedNews);
      } else if (result is ErrorRemote<List<Article>>) {
        return _defaultError(result.message);
      } else {
        return _defaultError("Unknown Error");
      }
    } catch (e) {
      return _defaultError(e.toString());
    }
  }

  @override
  Future<NewsItem> getHeadlineNews() async {
    final data = await localPref.getNews();
    if (data.isEmpty) {
      final result = await remote.getLatestNews();
      if (result is SuccessRemote<List<Article>>) {
        final newsData = result.data.first;
        return NewsItem(
            title: newsData.title,
            content: newsData.content,
            imgUrl: newsData.urlToImage);
      } else {
        NewsItem(
            title:
                "Tim De Chant Mycocycle uses mushrooms to upcycle old tires and construction waste | TechCrunch",
            content: "",
            imgUrl:
                "https://techcrunch.com/wp-content/uploads/2024/05/alphafold-3-deepmind.jpg?resize=1200,675");
      }
    }
    return data.first;
  }

  bool _isBookmarked(String key, List<NewsItem> cache) {
    return cache.any((item) => item.title == key);
  }

  Future<ErrorConsume<List<NewsItem>>> _defaultError(String message) async {
    return ErrorConsume<List<NewsItem>>(message, await localPref.getNews());
  }
}
