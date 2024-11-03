import 'package:hive/hive.dart';

import '../../../core/crypton/namex.dart';
import '../../model/ui/news_item.dart';

abstract class LocalBookmark {
  Future<void> addBookmarkNews(NewsItem newsItem);

  Future<List<NewsItem>> getAllBookmarkedNews();

  Future<void> updateBookmarkedNews(int key, NewsItem updatedNewsItem);

  Future<void> deleteBookmarkedNews(String key);

  Future<NewsItem?> getNewsItem(int key);
}

class LocalBookmarkImpl implements LocalBookmark {
  Future<Box<NewsItem>> get _box async =>
      await Hive.openBox<NewsItem>('bookmark',
          encryptionCipher: HiveAesCipher(await generateEncryptionKey()));

  @override
  Future<void> addBookmarkNews(NewsItem newsItem) async {
    var box = await _box;
    await box.add(newsItem);
  }

  @override
  Future<List<NewsItem>> getAllBookmarkedNews() async {
    var box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> updateBookmarkedNews(int key, NewsItem updatedNewsItem) async {
    var box = await _box;
    await box.put(key, updatedNewsItem);
  }

  @override
  Future<void> deleteBookmarkedNews(String key) async {
    var box = await _box;

    final list = box.values.toList();
    final index = list.indexWhere((data) => data.title == key);

    if (index >= 0) {
      box.deleteAt(index);
    }
  }

  @override
  Future<NewsItem?> getNewsItem(int key) async {
    var box = await _box;
    return box.get(key);
  }
}
