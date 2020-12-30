import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/helper/article.dart';

class News {
  List<Article> news = [];

  Future<void> getNews(String category) async {
    String url = 'https://newsapi.org/v2/top-headlines?'
        'category=$category&country=in&apiKey=9c32b0a65fd64b97bc82924563afd873';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var jsonData = jsonDecode(data);
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = new Article(
              title: element['title'],
              author: element['author'],
              url_to_image: element['urlToImage'],
              description: element['description'],
              content: element['content'],
              url: element['url']);
          news.add(article);
        }
      });
    } else {
      print(response.statusCode);
    }
  }
}
