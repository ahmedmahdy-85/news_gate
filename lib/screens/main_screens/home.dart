import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/article.dart';
import 'package:news_app/helper/news_api.dart';
import 'package:news_app/screens/main_screens/category_screen.dart';
import 'package:news_app/helper/blog_tile.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> images = [
    'assets/images/business.png',
    'assets/images/entertainment.jpg',
    'assets/images/general.jpg',
    'assets/images/health.jpg',
    'assets/images/science.jpg',
    'assets/images/sports.jpg',
    'assets/images/technology.jpg'
  ];

  List<String> names = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  bool _loading = true;
  List<Article> articles = List<Article>();

  Widget categoryContainer(String image, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryScreen(category: text.toLowerCase())));
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 10.0, right: 5.0, left: 5.0),
        child: Card(
          elevation: 10.0,
          color: Colors.transparent,
          child: Container(
            height: 50,
            width: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    News news = new News();
    await news.getNews('business');
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            Text(
              'Loose',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          images.length,
                          (index) =>
                              categoryContainer(images[index], names[index])),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ListView.builder(
                        controller: ScrollController(keepScrollOffset: true),
                        itemCount: articles.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            url: articles[index].url,
                            imageUrl: articles[index].url_to_image,
                            title: articles[index].title,
                            description: articles[index].description,
                          );
                        }),
                  ),
                ],
              ),
            )),
    );
  }
}
