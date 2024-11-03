import 'package:flutter/material.dart';
import 'package:news_app_flutter/feature/component/alert.dart';
import 'package:news_app_flutter/feature/ui/newslist/news_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../component/error_state.dart';
import '../../component/list_item.dart';
import '../../component/loading.dart';
import '../../component/sheet.dart';
import 'news_viewmodel.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NewsViewModel()..getAllData(),
        child: Consumer<NewsViewModel>(
          builder: (context, vm, builder) {
            return Stack(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    NewsHeadlineBuilder(vm: vm),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, top: 20, right: 12, bottom: 0),
                        child: Text(
                          "Today's Latest News",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    NewsListBuilder(vm: vm),
                  ],
                ),
              ),
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

class NewsHeadlineBuilder extends StatelessWidget {
  final NewsViewModel vm;

  const NewsHeadlineBuilder({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img_error_state.webp"),
              fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey, blurRadius: 10, blurStyle: BlurStyle.solid),
          ]),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(vm.headlineNews?.imgUrl ?? "",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return NewsItemCircularLoading(loadingProgress: loadingProgress);
            }, errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return const ImageErrorPlaceHolder();
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    vm.headlineNews?.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsListBuilder extends StatelessWidget {
  final NewsViewModel vm;

  const NewsListBuilder({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
