import 'package:flutter/cupertino.dart';

import '../../data/model/ui/consume_result.dart';
import '../../data/model/ui/news_item.dart';
import '../../data/repository/tech_crunch_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final TechCrunchRepository repository = TechCrunchRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _message = "";

  String get message => _message;

  final List<NewsItem> _newsData = [];

  List<NewsItem> get newsData => _newsData;

  Future<void> getLatestNews() async {
    _isLoading = true;
    notifyListeners();

    final result = await repository.getLatestNews();
    if (result is SuccessConsume<List<NewsItem>>) {
      _newsData.addAll(result.data);
    } else if (result is ErrorConsume<List<NewsItem>>) {
      _message = result.message;
      _newsData.addAll(result.data);
    }

    _isLoading = false;
    notifyListeners();
  }

  hideMessage() {
    _message = "";
    notifyListeners();
  }
}
