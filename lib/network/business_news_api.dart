import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/business_news.dart';
import '../model/sports_news.dart';

class BusinessNewsAPI {
  Future<BusinessNews> FetchNews(String category) async {
    final http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=db1d324c7e06452a96f93b5c4ffa4db8'));
    if (response.statusCode == 200) {
      return BusinessNews.fromJson(json.decode(response.body));
    } else {
      throw Exception('error');
    }
  }
  Future<SportsNews> FetchSportsNews(String category) async {
    final http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=db1d324c7e06452a96f93b5c4ffa4db8'));
    if (response.statusCode == 200) {
      return SportsNews.fromJson(json.decode(response.body));
    } else {
      throw Exception('error');
    }
  }
}
