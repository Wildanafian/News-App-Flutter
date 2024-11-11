import 'package:flutter/material.dart';

import '../../core/resouce/strings.dart';
import 'bookmark/bookmark_screen.dart';
import 'newslist/news_list_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey, blurRadius: 10, blurStyle: BlurStyle.solid),
          ],
        ),
        child: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: Colors.blue,
            selectedIndex: currentPage,
            elevation: 4,
            onDestinationSelected: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(Icons.home, color: Colors.white),
                  icon: Icon(Icons.home_outlined),
                  label: GetStrings.home),
              NavigationDestination(
                  selectedIcon: Icon(Icons.bookmark, color: Colors.white),
                  icon: Icon(Icons.bookmark_outline),
                  label: GetStrings.bookmark)
            ]),
      ),
      body: [const NewsListScreen(), const BookmarkScreen()][currentPage],
    );
  }
}
