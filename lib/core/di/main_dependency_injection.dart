import 'package:get_it/get_it.dart';
import 'package:news_app_flutter/core/di/provide_data.dart';
import 'package:news_app_flutter/core/di/provide_network.dart';

final di = GetIt.instance;

Future<void> provideDependencyInjection() async {
  provideNetwork();
  await provideSecureStorage();
  provideDataSource();
  provideRepository();
}
