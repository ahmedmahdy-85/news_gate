import 'package:flutter/material.dart';
import 'file:///C:/Users/amahdy/AndroidStudioProjects/news_app/lib/screens/main_screens/article_screen.dart';

class BlogTile extends StatelessWidget {
  final String description;
  final String url;
  final String title;
  final String imageUrl;
  BlogTile({this.url, this.title, this.description, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleScreen(
                      blogUrl: url,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10.0,
          child: Container(
            child: Column(
              children: [
                Image.network(imageUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 15.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
