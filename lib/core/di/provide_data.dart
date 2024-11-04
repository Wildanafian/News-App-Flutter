import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/di/main_dependency_injection.dart';

import '../../data/datasource/local/local_data.dart';
import '../../data/datasource/local/local_hive.dart';
import '../../data/datasource/remote/tech_crunch_remote.dart';
import '../../data/model/ui/news_item.dart';
import '../../data/repository/bookmark_repository.dart';
import '../../data/repository/tech_crunch_repository.dart';
import '../crypton/namex.dart';
import '../network/api_call.dart';

Future<void> provideSecureStorage() async {
  di.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  di.registerLazySingleton<Crypton>(
      () => Crypton(secureStorage: di<FlutterSecureStorage>()));

  di.registerSingletonAsync<Box<NewsItem>>(() async {
    return await Hive.openBox<NewsItem>('bookmark',
        encryptionCipher:
            HiveAesCipher(await di<Crypton>().generateEncryptionKey()));
  });

  await di.allReady();
}

void provideDataSource() {
  di.registerLazySingleton<LocalSource>(
      () => LocalSourceImpl(secureStorage: di<FlutterSecureStorage>()));

  di.registerLazySingleton<LocalBookmark>(
      () => LocalBookmarkImpl(pandoraBox: di<Box<NewsItem>>()));

  di.registerLazySingleton<TechCrunchRemote>(
      () => TechCrunchRemoteImpl(api: di<ApiCall>()));
}

void provideRepository() {
  di.registerLazySingleton<TechCrunchRepository>(() => TechCrunchRepositoryImpl(
      remote: di<TechCrunchRemote>(),
      localPref: di<LocalSource>(),
      localHive: di<LocalBookmark>()));

  di.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepositoryImpl(localSource: di<LocalBookmark>()));
}
