import 'package:flutter/material.dart';
import 'package:news_app_flutter/feature/component/alert.dart';
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
              ListView.builder(
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
                    );
                  }),
              if (vm.state.isLoading) const GeneralCircularLoading(),
              if (vm.state.message.isNotEmpty)
                ShowAlert(
                  content: vm.state.message,
                  onPressed: () {
                    vm.hideMessage();
                  },
                )
            ]);
          },
        ));
  }
}
