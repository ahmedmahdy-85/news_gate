import 'package:flutter/material.dart';
import 'package:news_app/helper/article.dart';
import 'package:news_app/helper/news_api.dart';
import 'package:news_app/helper/blog_tile.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> articles = List<Article>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    News news = new News();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'News',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Loose',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                    controller: ScrollController(keepScrollOffset: true),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].url_to_image,
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              ),
            ),
    );
  }
}
