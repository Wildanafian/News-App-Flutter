import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/model/ui/news_item.dart';

Future<void> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsItemAdapter());
}
