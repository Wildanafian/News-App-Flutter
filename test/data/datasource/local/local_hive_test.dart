import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/data/datasource/local/local_hive.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import 'local_hive_test.mocks.dart';

@GenerateMocks([Box<NewsItem>])
void main() {
  late MockBox<NewsItem> box;
  late LocalBookmarkImpl sut;

  setUp(() {
    box = MockBox();
    sut = LocalBookmarkImpl(pandoraBox: box);
  });

  group("Local hive", () {
    test("addBookmarkNews", () async {
      final data = NewsItem(
          title: "title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(box.add(data)).thenAnswer((_) async => Future.value(0));

      await sut.addBookmarkNews(data);
      verify(box.add(data)).called(1);
    });

    test("getAllBookmarkedNews", () async {
      final data = NewsItem(
          title: "good title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(box.values.toList()).thenReturn([data]);

      final result = await sut.getAllBookmarkedNews();

      expect(data.title, result.first.title);
    });

    test("deleteBookmarkedNews", () async {
      final data = NewsItem(
          title: "good title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(box.values.toList()).thenReturn([data]);

      await sut.deleteBookmarkedNews("good title");

      verify(box.deleteAt(any)).called(1);
    });
  });
}
