import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/model/ui/ui_state.dart';

import '../../../core/di/main_dependency_injection.dart';
import '../../../data/model/ui/consume_result.dart';
import '../../../data/model/ui/news_item.dart';
import '../../../data/repository/tech_crunch_repository.dart';

class BookmarkViewModel extends ChangeNotifier {
  final TechCrunchRepository repository = di<TechCrunchRepository>();

  final UIState<List<NewsItem>> _state = UIState<List<NewsItem>>(data: []);

  UIState<List<NewsItem>> get state => _state;

  Future<void> getLatestNews() async {
    _state.updateLoading(true);
    notifyListeners();

    final result = await repository.getLatestNews();
    if (result is SuccessConsume<List<NewsItem>>) {
      _state.updateData(result.data.take(2).toList());
    } else if (result is ErrorConsume<List<NewsItem>>) {
      _state.updateMessageWithData(result.data, result.message);
    }

    notifyListeners();
  }

  hideMessage() {
    _state.updateMessage("");
    notifyListeners();
  }
}
