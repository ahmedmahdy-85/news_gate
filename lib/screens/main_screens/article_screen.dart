import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String blogUrl;
  ArticleScreen({this.blogUrl});
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _loading = false;
    });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Text(
                'News',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Loose',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(flex: 2),
            ],
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(child: CircularProgressIndicator()),
              )
            : Container(
                height: size.height,
                width: size.width,
                child: WebView(
                  initialUrl: widget.blogUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              ));
  }
}
