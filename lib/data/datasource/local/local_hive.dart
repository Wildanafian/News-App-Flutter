import 'package:hive/hive.dart';

import '../../model/ui/news_item.dart';

abstract class LocalBookmark {
  Future<void> addBookmarkNews(NewsItem newsItem);

  Future<List<NewsItem>> getAllBookmarkedNews();

  Future<void> deleteBookmarkedNews(String key);
}

class LocalBookmarkImpl implements LocalBookmark {
  final Box<NewsItem> _box;

  LocalBookmarkImpl({required Box<NewsItem> pandoraBox}) : _box = pandoraBox;

  @override
  Future<void> addBookmarkNews(NewsItem newsItem) async {
    await _box.add(newsItem);
  }

  @override
  Future<List<NewsItem>> getAllBookmarkedNews() async {
    return _box.values.toList();
  }

  @override
  Future<void> deleteBookmarkedNews(String key) async {
    final list = _box.values.toList();
    final index = list.indexWhere((data) => data.title == key);

    if (index >= 0) {
      _box.deleteAt(index);
    }
  }
}
