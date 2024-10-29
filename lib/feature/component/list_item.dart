import 'package:flutter/material.dart';

import '../../data/model/ui/news_item.dart';
import 'error_state.dart';
import 'loading.dart';

class NewsItemView extends StatelessWidget {
  final NewsItem newsData;
  final Function(NewsItem data) onPressedImage;
  final Function(NewsItem data) onPressedTitle;

  const NewsItemView(
      {super.key,
      required this.newsData,
      required this.onPressedImage,
      required this.onPressedTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 6, right: 6),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => onPressedImage(newsData),
                    child: Image.network(newsData.imgUrl,
                        width: 100, height: double.infinity, fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return NewsItemCircularLoading(
                          loadingProgress: loadingProgress);
                    }, errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                      return const ImageErrorPlaceHolder();
                    }),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () => onPressedTitle(newsData),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsData.title,
                            style: textTheme.titleLarge,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              newsData.content,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
