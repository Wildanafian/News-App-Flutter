import 'package:flutter/material.dart';
import 'package:news_app_flutter/feature/ui/news_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("BBC News",
                style: textTheme.headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: const NewsListScreen(),
        ));
  }
}
