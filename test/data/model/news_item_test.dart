import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

void main() {
  test("news item copy should return value", () {
    final initial =
        NewsItem(title: "title", content: "content", imgUrl: "imgUrl");
    final edited = initial.copyWith(content: "wow");
    final expected = NewsItem(title: "title", content: "wow", imgUrl: "imgUrl");
    expect(expected.title, edited.title);
    expect(expected.content, edited.content);
    expect(expected.imgUrl, edited.imgUrl);
  });
}
