import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/model/ui/ui_state.dart';
import 'package:retry/retry.dart';

import '../../../core/di/main_dependency_injection.dart';
import '../../../core/helper/custom_exception.dart';
import '../../../data/model/ui/consume_result.dart';
import '../../../data/model/ui/news_item.dart';
import '../../../data/repository/tech_crunch_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final TechCrunchRepository repository = di<TechCrunchRepository>();

  final UIState<List<NewsItem>> _techState = UIState<List<NewsItem>>(data: []);

  UIState<List<NewsItem>> get state => _techState;

  final UIState<List<NewsItem>> _economyState =
      UIState<List<NewsItem>>(data: []);

  UIState<List<NewsItem>> get economyState => _economyState;

  Future<void> getLatestNews() async {
    _techState.updateLoading(true);
    notifyListeners();

    final resultTech = await repository.getTechNews();
    if (resultTech is SuccessConsume<List<NewsItem>>) {
      _techState.updateData(resultTech.data);
    } else if (resultTech is ErrorConsume<List<NewsItem>>) {
      _techState.updateMessageWithData(resultTech.data, resultTech.message);
    }

    final resultEconomy = await repository.getEconomyNews();
    if (resultEconomy is SuccessConsume<List<NewsItem>>) {
      _economyState.updateData(resultEconomy.data);
    } else if (resultEconomy is ErrorConsume<List<NewsItem>>) {
      _techState.updateMessageWithData(
          resultEconomy.data, resultEconomy.message);
    }

    notifyListeners();
  }

  NewsItem _headlineNews = NewsItem(title: '', content: '', imgUrl: '');

  NewsItem get headlineNews => _headlineNews;

  Future<void> getHeadlineNews() async {
    final headlineNews = await retry(() => repository.getHeadlineNews(),
        retryIf: (e) => e is EmptyHeadlineException);
    _headlineNews = headlineNews;
    notifyListeners();
  }

  Future<void> getAllData() async {
    getHeadlineNews();
    getLatestNews();
  }

  hideMessage() {
    _techState.updateMessage("");
    notifyListeners();
  }

  void handleTechBookmark(int index) {
    final bookmarkState = _techState.data[index].isBookmarked;
    _techState.data[index].isBookmarked = !bookmarkState;
    notifyListeners();
  }

  void handleEconomyBookmark(int index) {
    final bookmarkState = _economyState.data[index].isBookmarked;
    _economyState.data[index].isBookmarked = !bookmarkState;
    notifyListeners();
  }
}
