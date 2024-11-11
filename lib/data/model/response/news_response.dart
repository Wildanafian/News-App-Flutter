import 'dart:convert';

// To parse this JSON data, do
//     final newsResponse = newsResponseFromJson(jsonString);

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  String status;
  String? message;
  int? totalResults;
  List<Article>? articles;

  NewsResponse({
    required this.status,
    this.message,
    this.totalResults,
    this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        message: json["message"],
        totalResults: json["totalResults"],
        articles: json["articles"] != null
            ? List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x)))
            : [], // Provide an empty list if articles is null
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalResults": totalResults,
        "articles": articles != null
            ? List<dynamic>.from(articles!.map((x) => x.toJson()))
            : [],
      };
}

class Article {
  Source source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

class Source {
  String? id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
