import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_app_flutter/core/di/main_dependency_injection.dart';

import '../../data/datasource/local/local_data.dart';
import '../../data/datasource/remote/tech_crunch_remote.dart';
import '../../data/repository/tech_crunch_repository.dart';

void provideSecureStorage() {
  di.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
}

void provideDataSource() {
  di.registerLazySingleton<LocalSource>(() => LocalSourceImpl());

  di.registerLazySingleton<TechCrunchRemote>(() => TechCrunchRemoteImpl());
}

void provideRepository() {
  di.registerLazySingleton<TechCrunchRepository>(
      () => TechCrunchRepositoryImpl());
}
