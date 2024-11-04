import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_flutter/core/constant/general_constant.dart';
import 'package:news_app_flutter/data/datasource/local/local_data.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import 'local_source_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  late LocalSourceImpl sut;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    sut = LocalSourceImpl(secureStorage: mockSecureStorage);
  });

  group('cacheNews', () {
    test('should save news data to secure storage', () async {
      final newsData = [
        NewsItem(title: 'Title', content: 'Content', imgUrl: 'Content')
      ];
      final encodedData = jsonEncode(newsData.map((e) => e.toJson()).toList());

      // Act
      await sut.cacheNews(newsData);

      // Assert
      verify(mockSecureStorage.write(
        key: GeneralConst.newsData,
        value: encodedData,
      )).called(1);
    });
  });

  group('getNews', () {
    test('should return cached news data if available', () async {
      final newsData = [
        NewsItem(title: 'Title', content: 'Content', imgUrl: 'Content')
      ];
      final encodedData = jsonEncode(newsData.map((e) => e.toJson()).toList());

      // Arrange
      when(mockSecureStorage.read(key: GeneralConst.newsData))
          .thenAnswer((_) async => encodedData);

      // Act
      final result = await sut.getNews();

      // Assert
      expect(result, isA<List<NewsItem>>());
      expect(result.length, newsData.length);
      expect(result.first.title, newsData.first.title);
    });

    test('should return an empty list if no cached data is found', () async {
      // Arrange
      when(mockSecureStorage.read(key: GeneralConst.newsData))
          .thenAnswer((_) async => null);

      // Act
      final result = await sut.getNews();

      // Assert
      expect(result, isEmpty);
    });
  });
}
