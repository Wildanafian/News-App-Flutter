import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/core/network/api_call.dart';

import 'api_call_test.mocks.dart';

@GenerateMocks([InterceptedClient])
void main() {
  late MockInterceptedClient mockedClient;
  late ApiCallImpl sut;

  setUp(() {
    mockedClient = MockInterceptedClient();
    sut = ApiCallImpl(httpClient: mockedClient);
  });

  group("Tech news", () {
    test("should return value", () async {
      final body = Response("success", 200);

      when(mockedClient.get(any)).thenAnswer((_) => Future.value(body));

      expect(body, await sut.fetchTechNews());
    });
  });

  group("Economy news", () {
    test("should return value", () async {
      final body = Response("success", 200);

      when(mockedClient.get(any)).thenAnswer((_) => Future.value(body));

      expect(body, await sut.fetchEconomyNews());
    });
  });
}
