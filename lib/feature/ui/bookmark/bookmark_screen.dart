import 'package:flutter/material.dart';
import 'package:news_app_flutter/feature/ui/newslist/news_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../component/list_item.dart';
import '../../component/loading.dart';
import '../../component/sheet.dart';
import 'bookmark_viewmodel.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BookmarkViewModel()..getLatestNews(),
        child: Consumer<BookmarkViewModel>(
          builder: (context, vm, builder) {
            return Stack(children: [
              ListView.separated(
                itemCount: vm.state.data.length,
                itemBuilder: (context, index) {
                  final newsData = vm.state.data[index];
                  return NewsItemView(
                    newsData: newsData,
                    onPressedImage: (data) {
                      detailSheet(context, data);
                    },
                    onPressedTitle: (data) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(data: data)),
                      );
                    },
                    onPressedBookmark: (data) {
                      vm.deleteNews(data.title);
                      vm.getLatestNews();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 6);
                },
              ),
              if (vm.state.isLoading) const GeneralCircularLoading(),
              if (vm.state.data.isEmpty)
                Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bookmark_outline,
                            color: Colors.grey, size: 100),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Lets bookmark some good news!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ]);
          },
        ));
  }
}
