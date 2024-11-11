import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/resouce/text_style.dart';
import 'package:news_app_flutter/data/model/ui/news_item.dart';

import 'error_state.dart';
import 'loading.dart';

void detailSheet(BuildContext context, NewsItem data) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView(
          children: [
            Image.network(
              data.imgUrl,
              height: 250,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const NewsItemCircularLoading();
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const ImageErrorPlaceHolder();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 6, right: 12),
              child: Text(
                data.title,
                style: GetStyle.mediumBoldBlack,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 8, bottom: 30),
              child: Text(
                data.content,
                style: GetStyle.normalNormalBlack,
              ),
            ),
          ],
        ),
      );
    },
  );
}
