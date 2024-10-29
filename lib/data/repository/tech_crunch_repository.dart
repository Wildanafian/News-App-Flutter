import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import '../datasource/local/local_data.dart';
import '../model/ui/consume_result.dart';
import '../model/ui/remote_result.dart';

class TechCrunchRepository {
  TechCrunchRemote remote = TechCrunchRemote();
  LocalSource localSource = LocalSource();

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
        return defaultError(result.message);
      } else {
        return defaultError("Unknown Error");
      }
    } catch (e) {
      return defaultError(e.toString());
    }
  }

  Future<ErrorConsume<List<NewsItem>>> defaultError(String message) async {
    return ErrorConsume<List<NewsItem>>(message, await localSource.getNews());
  }
}
