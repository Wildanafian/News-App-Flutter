import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/core/constant/general_constant.dart';
import 'package:news_app_flutter/core/helper/custom_exception.dart';
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
  late MockLocalBookmark localBookmark;
  late MockLocalSource localSource;
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

  group("get Tech News", () {
    test("should return data", () async {
      when(remote.getTechLatestNews())
          .thenAnswer((_) async => Future.value(SuccessRemote([article])));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getTechNews();

      expect(1, (result as SuccessConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });

    test("should return error with data", () async {
      when(remote.getTechLatestNews())
          .thenAnswer((_) async => Future.value(ErrorRemote("failed bruh")));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      when(localSource.getNews(GeneralConst.techData))
          .thenAnswer((_) async => Future.value([bookmark]));

      await localSource.getNews(GeneralConst.techData);
      final result = await sut.getTechNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
      expect("failed bruh", result.message);
    });

    test("should return error bcs of caching exception", () async {
      when(remote.getTechLatestNews())
          .thenThrow(Exception("you got some exception"));

      when(localSource.getNews(GeneralConst.techData))
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getTechNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });
  });

  group("get Economy News", () {
    test("should return data", () async {
      when(remote.getEconomyLatestNews())
          .thenAnswer((_) async => Future.value(SuccessRemote([article])));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getEconomyNews();

      expect(1, (result as SuccessConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
    });

    test("should return error with data", () async {
      when(remote.getEconomyLatestNews())
          .thenAnswer((_) async => Future.value(ErrorRemote("failed bruh")));

      when(localBookmark.getAllBookmarkedNews())
          .thenAnswer((_) async => Future.value([bookmark]));

      when(localSource.getNews(GeneralConst.economyData))
          .thenAnswer((_) async => Future.value([bookmark]));

      await localSource.getNews(GeneralConst.economyData);
      final result = await sut.getEconomyNews();

      expect(1, (result as ErrorConsume<List<NewsItem>>).data.length);
      expect("asd", result.data.first.title);
      expect(true, result.data.first.isBookmarked);
      expect("failed bruh", result.message);
    });

    test("should return error bcs of caching exception", () async {
      when(remote.getEconomyLatestNews())
          .thenThrow(Exception("you got some exception"));

      when(localSource.getNews(GeneralConst.economyData))
          .thenAnswer((_) async => Future.value([bookmark]));

      final result = await sut.getEconomyNews();

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

      when(localSource.getNews(any)).thenAnswer((_) async =>
          Future.value([data, data, data, data, data, data, data, data, data]));

      final result = await sut.getHeadlineNews();

      expect(data.title, result.title);
    });

    test("localSource.getNews() is empty then should throw exception",
        () async {
      try {
        when(localSource.getNews(any))
            .thenAnswer((_) async => Future.value([]));
        await sut.getHeadlineNews();
      } on Exception catch (e) {
        expect(e, isA<EmptyHeadlineException>());
        expect("Headline news is empty", e.toString());
      }
    });
  });
}
