import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/model/ui/ui_state.dart';

import '../../../core/di/main_dependency_injection.dart';
import '../../../data/model/ui/news_item.dart';
import '../../../data/repository/bookmark_repository.dart';

class BookmarkViewModel extends ChangeNotifier {
  final BookmarkRepository repository = di<BookmarkRepository>();

  final UIState<List<NewsItem>> _state = UIState<List<NewsItem>>(data: []);

  UIState<List<NewsItem>> get state => _state;

  Future<void> getLatestNews() async {
    _state.updateLoading(true);
    notifyListeners();

    _state.updateData(await repository.getAllBookmarkedNews());
    notifyListeners();
  }

  void bookmarkNews(NewsItem data) async {
    repository.addBookmarkNews(data);
  }

  void deleteNews(String key) async {
    await repository.deleteBookmarkedNews(key);
  }

  void handleBookmarkState(int index) {
    final bookmarkState = _state.data[index].isBookmarked;
    _state.data[index].isBookmarked = !bookmarkState;
    notifyListeners();
  }
}
