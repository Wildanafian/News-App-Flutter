import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/core/network/api_call.dart';
import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart';
import 'package:news_app_flutter/data/model/response/news_response.dart';
import 'package:news_app_flutter/data/model/ui/remote_result.dart';

import 'tech_crunch_remote_test.mocks.dart';

@GenerateMocks([ApiCall])
void main() {
  late MockApiCall apiCall;
  late TechCrunchRemoteImpl sut;

  setUp(() {
    apiCall = MockApiCall();
    sut = TechCrunchRemoteImpl(api: apiCall);
  });

  group("get news", () {
    test("hit getLatestNews should return success data", () async {
      final article = Article(
          source: Source(name: "asd"),
          title: "asd",
          description: "zxc",
          url: "zxc",
          urlToImage: "zxc",
          publishedAt: DateTime(0),
          content: "lorem");

      final rawBody =
          NewsResponse(status: "200", message: "success", articles: [article]);

      final body = Response(newsResponseToJson(rawBody), 200);
      when(apiCall.fetchNews()).thenAnswer((_) async => body);

      final result = await sut.getLatestNews();
      expect(article.title,
          (result as SuccessRemote<List<Article>>).data.first.title);
    });

    test("hit getLatestNews should return error message", () async {
      final rawBody =
          NewsResponse(status: "400", message: "failed", articles: []);

      final body = Response(newsResponseToJson(rawBody), 400);
      when(apiCall.fetchNews()).thenAnswer((_) async => body);

      final result = await sut.getLatestNews();
      expect("failed", (result as ErrorRemote<List<Article>>).message);
    });
  });
}
