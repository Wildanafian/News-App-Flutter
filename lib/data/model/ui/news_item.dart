class NewsItem {
  final String title;
  final String content;
  final String imgUrl;

  NewsItem({required this.title, required this.content, required this.imgUrl});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imgUrl': imgUrl,
    };
  }

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      content: json['content'],
      imgUrl: json['imgUrl'],
    );
  }
}
