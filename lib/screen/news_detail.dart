import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final String url;
  final String title;
  NewsDetailScreen({this.url, this.title});
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      initialChild: Container(
          child: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Loading"),
            SizedBox(height: 5),
            CircularProgressIndicator(),
          ],
        )),
      )),
      url: widget.url,
      appBar: AppBar(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      withZoom: true,
      hidden: true,
      withLocalStorage: true,
    );
  }
}
