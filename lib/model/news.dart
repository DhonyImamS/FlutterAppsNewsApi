import 'package:equatable/equatable.dart';

enum NewsCategory {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}

String getCategoryText(NewsCategory newsCategory) {
  String result = "";
  switch (newsCategory) {
    case NewsCategory.business:
      result = "Bisnis";
      break;
    case NewsCategory.entertainment:
      result = "Entertainment";
      break;
    case NewsCategory.general:
      result = "Umum";
      break;
    case NewsCategory.health:
      result = "Kesehatan";
      break;
    case NewsCategory.science:
      result = "Sains";
      break;
    case NewsCategory.sports:
      result = "Olahraga";
      break;
    case NewsCategory.technology:
      result = "Teknologi";
      break;
    default:
  }
  return result;
}

String getCategory(NewsCategory newsCategory) {
  String result = "";
  switch (newsCategory) {
    case NewsCategory.business:
      result = "business";
      break;
    case NewsCategory.entertainment:
      result = "entertainment";
      break;
    case NewsCategory.general:
      result = "general";
      break;
    case NewsCategory.health:
      result = "health";
      break;
    case NewsCategory.science:
      result = "science";
      break;
    case NewsCategory.sports:
      result = "sports";
      break;
    case NewsCategory.technology:
      result = "technology";
      break;
    default:
  }
  return result;
}

class News extends Equatable {
  final List<Articles> articles;
  News({this.articles});

  factory News.fromJSON(Map<String, dynamic> json) {
    List<Articles> articles = (json['articles'] as List).map((i) => Articles.fromJSON(i)).toList();
    return News(
      articles: articles,
    );
  }

  @override
  List<Object> get props => [articles];
}

class Articles extends Equatable {
  final String sourceId;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  const Articles({
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Articles.fromJSON(Map<String, dynamic> json) {
    return Articles(
      sourceId: json['source']['id'],
      sourceName: json['source']['name'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
    );
  }

  @override
  List<Object> get props => [
        sourceId,
        sourceName,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

class Source extends Equatable {
  final List<NewsSource> newsSource;
  const Source({this.newsSource});

  factory Source.fromJSON(Map<String, dynamic> json) {
    List<NewsSource> newsSource = (json['sources'] as List).map((i) => NewsSource.fromJSON(i)).toList();
    return Source(
      newsSource: newsSource,
    );
  }
  // List<NewsSource> search(String search) {
  //   //return
  //   this.newsSource = this.newsSource.where((food) => food.name.toLowerCase().contains(userInputValue.toLowerCase()).toList();
  // }

  @override
  List<Object> get props => [newsSource];
}

class NewsSource extends Equatable {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const NewsSource({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        url,
        category,
        language,
        country,
      ];

  factory NewsSource.fromJSON(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}
