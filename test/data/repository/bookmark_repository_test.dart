import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/data/datasource/local/local_hive.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';
import 'package:news_app_flutter/data/repository/bookmark_repository.dart';

import 'bookmark_repository_test.mocks.dart';

@GenerateMocks([LocalBookmark])
void main() {
  late LocalBookmark localSource;
  late BookmarkRepositoryImpl sut;

  setUp(() {
    localSource = MockLocalBookmark();
    sut = BookmarkRepositoryImpl(localSource: localSource);
  });

  group("BookmarkRepository", () {
    test("addBookmarkNews should return  success called", () async {
      final data = NewsItem(
          title: "title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(localSource.addBookmarkNews(data))
          .thenAnswer((_) async => Future<void>);

      await sut.addBookmarkNews(data);

      verify(localSource.addBookmarkNews(data)).called(1);
    });

    test("getAllBookmarkedNews should return value", () async {
      final data = [
        NewsItem(
            title: "title",
            content: "content",
            imgUrl: "imgUrl",
            isBookmarked: true)
      ];

      when(localSource.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value(data));

      final result = await sut.getAllBookmarkedNews();

      expect(1, result.length);
      expect("title", result.first.title);
    });

    test("deleteBookmarkedNews should success called", () async {
      when(localSource.deleteBookmarkedNews("title"))
          .thenAnswer((_) async => Future<void>);

      await sut.deleteBookmarkedNews("title");

      verify(localSource.deleteBookmarkedNews("title")).called(1);
    });
  });
}
