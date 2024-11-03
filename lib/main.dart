import 'package:flutter/material.dart';

import 'core/di/main_dependency_injection.dart';
import 'feature/ui/bottom_navigation_bar.dart';

void main() {
  provideDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const BottomNavigation());
  }
}
