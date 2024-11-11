import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/resouce/text_style.dart';

import '../../../core/helper/nofication_permission.dart';
import '../../../core/resouce/strings.dart';
import '../../../data/model/ui/news_item.dart';
import '../../component/error_state.dart';
import '../../component/loading.dart';

class DetailScreen extends StatelessWidget {
  final NewsItem data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    requestCameraPermission();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
              title:
                  const Text(GetStrings.detail, style: GetStyle.toolbarBlack),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: ListView(
            children: [
              CachedNetworkImage(
                imageUrl: data.imgUrl,
                height: 300,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const NewsItemCircularLoading(),
                errorWidget: (context, url, error) =>
                    const ImageErrorPlaceHolder(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6, right: 12),
                child: Text(
                  data.title,
                  style: GetStyle.largeBoldBlack,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 12, right: 8, bottom: 30),
                child: Text(
                  data.content + data.content + data.content,
                  style: GetStyle.normalNormalBlack,
                ),
              ),
            ],
          ),
        ));
  }
}
