import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import '../../core/di/main_dependency_injection.dart';
import '../datasource/local/local_data.dart';
import '../model/ui/consume_result.dart';
import '../model/ui/remote_result.dart';

abstract class TechCrunchRepository {
  Future<ConsumeResult<List<NewsItem>>> getLatestNews();

  Future<NewsItem> getHeadlineNews();
}

class TechCrunchRepositoryImpl implements TechCrunchRepository {
  final TechCrunchRemote remote = di<TechCrunchRemote>();
  final LocalSource localSource = di<LocalSource>();

  @override
  Future<ConsumeResult<List<NewsItem>>> getLatestNews() async {
    try {
      final result = await remote.getLatestNews();

      if (result is SuccessRemote<List<Article>>) {
        final mappedNews = result.data
            .map((data) => NewsItem(
                title: data.title,
                content: data.content + data.description,
                imgUrl: data.urlToImage))
            .toList();
        localSource.cacheNews(mappedNews);
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
    final data = await localSource.getNews();
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

  Future<ErrorConsume<List<NewsItem>>> _defaultError(String message) async {
    return ErrorConsume<List<NewsItem>>(message, await localSource.getNews());
  }
}
