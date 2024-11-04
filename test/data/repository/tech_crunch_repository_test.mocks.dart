// Mocks generated by Mockito 5.4.4 from annotations
// in news_app_flutter/test/data/repository/tech_crunch_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:news_app_flutter/data/datasource/local/local_data.dart' as _i3;
import 'package:news_app_flutter/data/datasource/local/local_hive.dart' as _i6;
import 'package:news_app_flutter/data/datasource/remote/tech_crunch_remote.dart'
    as _i7;
import 'package:news_app_flutter/data/model/response/news_response.dart' as _i8;
import 'package:news_app_flutter/data/model/ui/news_item.dart' as _i5;
import 'package:news_app_flutter/data/model/ui/remote_result.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRemoteResult_0<T> extends _i1.SmartFake
    implements _i2.RemoteResult<T> {
  _FakeRemoteResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocalSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalSource extends _i1.Mock implements _i3.LocalSource {
  MockLocalSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> cacheNews(List<_i5.NewsItem>? newsData) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNews,
          [newsData],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i5.NewsItem>> getNews() => (super.noSuchMethod(
        Invocation.method(
          #getNews,
          [],
        ),
        returnValue: _i4.Future<List<_i5.NewsItem>>.value(<_i5.NewsItem>[]),
      ) as _i4.Future<List<_i5.NewsItem>>);
}

/// A class which mocks [LocalBookmark].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalBookmark extends _i1.Mock implements _i6.LocalBookmark {
  MockLocalBookmark() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> addBookmarkNews(_i5.NewsItem? newsItem) =>
      (super.noSuchMethod(
        Invocation.method(
          #addBookmarkNews,
          [newsItem],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i5.NewsItem>> getAllBookmarkedNews() => (super.noSuchMethod(
        Invocation.method(
          #getAllBookmarkedNews,
          [],
        ),
        returnValue: _i4.Future<List<_i5.NewsItem>>.value(<_i5.NewsItem>[]),
      ) as _i4.Future<List<_i5.NewsItem>>);

  @override
  _i4.Future<void> deleteBookmarkedNews(String? key) => (super.noSuchMethod(
        Invocation.method(
          #deleteBookmarkedNews,
          [key],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [TechCrunchRemote].
///
/// See the documentation for Mockito's code generation for more information.
class MockTechCrunchRemote extends _i1.Mock implements _i7.TechCrunchRemote {
  MockTechCrunchRemote() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.RemoteResult<List<_i8.Article>>> getLatestNews() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLatestNews,
          [],
        ),
        returnValue: _i4.Future<_i2.RemoteResult<List<_i8.Article>>>.value(
            _FakeRemoteResult_0<List<_i8.Article>>(
          this,
          Invocation.method(
            #getLatestNews,
            [],
          ),
        )),
      ) as _i4.Future<_i2.RemoteResult<List<_i8.Article>>>);
}