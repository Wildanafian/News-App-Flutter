import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/data/datasource/local/local_data.dart';
import 'package:news_app_flutter/data/datasource/local/local_hive.dart';
import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/consume_result.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';
import 'package:news_app_flutter/data/model/ui/remote_result.dart';
import 'package:news_app_flutter/data/repository/tech_crunch_repository.dart';

import 'tech_crunch_repository_test.mocks.dart';

@GenerateMocks([LocalSource, LocalBookmark, TechCrunchRemote])
void main() {
  late LocalBookmark localBookmark;
  late LocalSource localSource;
  late TechCrunchRemote remote;
  late TechCrunchRepositoryImpl sut;

  final article = Article(
      source: Source(name: "asd"),
      title: "asd",
      description: "zxc",
      url: "zxc",
      urlToImage: "zxc",
      publishedAt: DateTime(0),
      content: "lorem");

  final bookmark = NewsItem(
      title: "asd", content: "lorem", imgUrl: "zxc", isBookmarked: true);

  setUp(() {
    localSource = MockLocalSource();
    localBookmark = MockLocalBookmark();
    remote = MockTechCrunchRemote();
    sut = TechCrunchRepositoryImpl(
        remote: remote, localPref: localSource, localHive: localBookmark);
  });

  group("TechCrunchRepository", () {
    test("hit getLatestNews then should return data", () async {
      when(remote.getLatestNews())
          .thenAnswer((_) async => Future.value(SuccessRemote([article])));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getLatestNews();

      expect(1, (result as SuccessConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });

    test("hit getLatestNews then should return error with data", () async {
      when(remote.getLatestNews())
          .thenAnswer((_) async => Future.value(ErrorRemote("failed bruh")));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      when(localSource.getNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      await localSource.getNews();
      final result = await sut.getLatestNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
      expect("failed bruh", result.message);
    });

    test("hit getLatestNews then should return error bcs of caching exception",
        () async {
      when(remote.getLatestNews())
          .thenThrow(Exception("you got some exception"));

      when(localSource.getNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getLatestNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });

    test("getHeadlineNews should return data", () async {
      final data = NewsItem(
          title: "title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(localSource.getNews()).thenAnswer((_) async => Future.value([data]));

      final result = await sut.getHeadlineNews();

      expect(data.title, result.title);
    });
  });
}
