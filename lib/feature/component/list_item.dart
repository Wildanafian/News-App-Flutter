import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/resouce/text_style.dart';
import '../../data/model/ui/news_item.dart';
import 'error_state.dart';
import 'loading.dart';

class NewsItemView extends StatelessWidget {
  final NewsItem newsData;
  final Function(NewsItem data) onPressedImage;
  final Function(NewsItem data) onPressedTitle;
  final Function(NewsItem data) onPressedBookmark;

  const NewsItemView(
      {super.key,
      required this.newsData,
      required this.onPressedImage,
      required this.onPressedTitle,
      required this.onPressedBookmark});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onPressedImage(newsData),
              child: CachedNetworkImage(
                  imageUrl: newsData.imgUrl,
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const NewsItemCircularLoading(),
                  errorWidget: (context, url, error) =>
                      const ImageErrorPlaceHolder()),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () => onPressedTitle(newsData),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 12, bottom: 12, right: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsData.title,
                      style: GetStyle.mediumBoldBlack,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        newsData.content,
                        style: GetStyle.smallNormalGray,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                    onTap: () => onPressedBookmark(newsData),
                    child: Icon(
                      newsData.isBookmarked ?? false
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: newsData.isBookmarked ?? false
                          ? Colors.blue
                          : Colors.grey,
                    )))
          ],
        ),
      ),
    );
  }
}
