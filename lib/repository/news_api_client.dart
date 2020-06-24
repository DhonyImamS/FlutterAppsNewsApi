import 'dart:convert';

import 'package:binar/model/news.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class NewsApiClient {
  static const baseUrl = 'http://newsapi.org/v2';
  static const apiKey = '485cdb0f4c984b1ea5ad5260e925f5c0';
  final http.Client httpClient;

  NewsApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<News> fetchDataNews(String sourceId) async {
    final apiUrl = '$baseUrl/top-headlines?sources=$sourceId&apiKey=$apiKey';
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return News.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Data");
    }
  }

  Future<Source> fetchDataNewsSource(String category) async {
    final apiUrl = '$baseUrl/sources?category=$category&apiKey=$apiKey';
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return Source.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Data");
    }
  }
}
