import 'package:cached_network_image/cached_network_image.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/resouce/text_style.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';
import 'package:news_app_flutter/feature/component/alert.dart';
import 'package:news_app_flutter/feature/ui/bookmark/bookmark_viewmodel.dart';
import 'package:news_app_flutter/feature/ui/newslist/news_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/resouce/strings.dart';
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
              RefreshIndicator(
                onRefresh: () async {
                  vm.getAllData();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NewsHeadlineBuilder(vm: vm),
                      TabBuilder(vm: vm),
                    ],
                  ),
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

class TabBuilder extends StatelessWidget {
  final NewsViewModel vm;

  const TabBuilder({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              labelStyle: GetStyle.largeBoldBlack,
              tabs: [
                Tab(text: (GetStrings.tech)),
                Tab(text: GetStrings.economy)
              ],
            ),
          ),
          ContentSizeTabBarView(
            children: [
              NewsListBuilder(
                  newsData: vm.state.data,
                  onTapBookmark: (index) {
                    vm.handleTechBookmark(index);
                  }),
              NewsListBuilder(
                  newsData: vm.economyState.data,
                  onTapBookmark: (index) {
                    vm.handleEconomyBookmark(index);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsHeadlineBuilder extends StatelessWidget {
  final NewsViewModel vm;

  const NewsHeadlineBuilder({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
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
              child: CachedNetworkImage(
                  imageUrl: vm.headlineNews.imgUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const NewsItemCircularLoading(),
                  errorWidget: (context, url, error) =>
                      const ImageErrorPlaceHolder())),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(150, 33, 150, 243), // 80% opacity blue
                  Color.fromARGB(150, 76, 169, 80),
                ]),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 8.0, bottom: 8.0, right: 8.0),
                  child: Text(
                    vm.headlineNews.title,
                    style: GetStyle.mediumBoldWhite,
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
  final List<NewsItem> newsData;
  final Function(int index) onTapBookmark;

  const NewsListBuilder(
      {super.key, required this.newsData, required this.onTapBookmark});

  @override
  Widget build(BuildContext context) {
    final vmBookmark = BookmarkViewModel();
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 8, right: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          final newsData = this.newsData[index];
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
              if (data.isBookmarked == false) {
                vmBookmark.bookmarkNews(data.copyWith(isBookmarked: true));
              } else {
                vmBookmark.deleteNews(data.title);
              }
              onTapBookmark(index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 6);
        },
      ),
    );
  }
}
