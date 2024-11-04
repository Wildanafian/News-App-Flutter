import '../datasource/local/local_hive.dart';
import '../model/ui/news_item.dart';

abstract class BookmarkRepository {
  Future<void> addBookmarkNews(NewsItem newsItem);

  Future<List<NewsItem>> getAllBookmarkedNews();

  Future<void> deleteBookmarkedNews(String key);
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  final LocalBookmark localSource;

  BookmarkRepositoryImpl({required this.localSource});

  @override
  Future<void> addBookmarkNews(newsItem) async {
    localSource.addBookmarkNews(newsItem);
  }

  @override
  Future<void> deleteBookmarkedNews(String key) async {
    localSource.deleteBookmarkedNews(key);
  }

  @override
  Future<List<NewsItem>> getAllBookmarkedNews() {
    return localSource.getAllBookmarkedNews();
  }
}
