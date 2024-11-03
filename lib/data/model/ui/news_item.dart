import 'package:hive/hive.dart';

part 'news_item.g.dart';

@HiveType(typeId: 1)
class NewsItem {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String imgUrl;

  @HiveField(3)
  bool isBookmarked;

  NewsItem(
      {required this.title,
      required this.content,
      required this.imgUrl,
      this.isBookmarked = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imgUrl': imgUrl,
      'isBookmarked': isBookmarked,
    };
  }

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      content: json['content'],
      imgUrl: json['imgUrl'],
      isBookmarked: json['isBookmarked'],
    );
  }

  NewsItem copyWith({
    String? title,
    String? content,
    String? imgUrl,
    bool? isBookmarked,
  }) {
    return NewsItem(
      title: title ?? this.title,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
