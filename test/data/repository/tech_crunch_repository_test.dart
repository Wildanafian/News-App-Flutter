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

  group("getLatestNews", () {
    test("should return data", () async {
      when(remote.getLatestNews())
          .thenAnswer((_) async => Future.value(SuccessRemote([article])));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getLatestNews();

      expect(1, (result as SuccessConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });

    test("should return error with data", () async {
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

    test("should return error bcs of caching exception", () async {
      when(remote.getLatestNews())
          .thenThrow(Exception("you got some exception"));

      when(localSource.getNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getLatestNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });
  });

  group("getHeadlineNews", () {
    test("localSource.getNews() is not empty then should return data",
        () async {
      final data = NewsItem(
          title: "title",
          content: "content",
          imgUrl: "imgUrl",
          isBookmarked: true);

      when(localSource.getNews()).thenAnswer((_) async => Future.value([data]));

      final result = await sut.getHeadlineNews();

      expect(data.title, result.title);
    });

    test("localSource.getNews() is empty then should return data", () async {
      when(localSource.getNews()).thenAnswer((_) async => Future.value([]));

      when(remote.getLatestNews())
          .thenAnswer((_) async => Future.value(SuccessRemote([article])));

      final data = NewsItem(
          title: article.title,
          content: article.content,
          imgUrl: article.urlToImage);

      final result = await sut.getHeadlineNews();

      expect(data.title, result.title);
    });

    test("localSource.getLatestNews() is error then should return data",
        () async {
      when(localSource.getNews()).thenAnswer((_) async => Future.value([]));

      when(remote.getLatestNews())
          .thenAnswer((_) async => Future.value(ErrorRemote("error")));

      final data = NewsItem(
          title:
              "Tim De Chant Mycocycle uses mushrooms to upcycle old tires and construction waste | TechCrunch",
          content: "",
          imgUrl:
              "https://techcrunch.com/wp-content/uploads/2024/05/alphafold-3-deepmind.jpg?resize=1200,675");

      final result = await sut.getHeadlineNews();

      expect(data.title, result.title);
    });
  });
}
