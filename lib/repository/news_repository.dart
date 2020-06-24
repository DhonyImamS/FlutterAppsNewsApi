import 'dart:async';
import 'package:binar/model/news.dart';
import 'package:meta/meta.dart';

import 'news_api_client.dart';

class NewsRepository {
  final NewsApiClient newsApiClient;
  NewsRepository({@required this.newsApiClient}) : assert(newsApiClient != null);

  Future<News> getNews(String sourceId) async {
    return await newsApiClient.fetchDataNews(sourceId);
  }

  Future<Source> getNewsSource(String category) async {
    return await newsApiClient.fetchDataNewsSource(category);
  }
}
