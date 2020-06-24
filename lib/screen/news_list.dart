import 'package:binar/bloc/news.dart';
import 'package:binar/bloc/news_bloc.dart';
import 'package:binar/model/news.dart';
import 'package:binar/repository/news_api_client.dart';
import 'package:binar/repository/news_repository.dart';
import 'package:binar/screen/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class NewsListScreen extends StatefulWidget {
  final String sourceId;
  NewsListScreen({this.sourceId});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsRepository newsRepository = NewsRepository(
    newsApiClient: NewsApiClient(
      httpClient: http.Client(),
    ),
  );
  NewsBloc _blocNews;
  final TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _blocNews = NewsBloc(newsRepository: newsRepository);
    _blocNews.add(NewsRequested(sourceId: widget.sourceId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Berita"),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: _blocNews,
        builder: (context, state) {
          Widget _body;
          if (state is NewsInitial) {
            _body = Text("Start");
          }
          if (state is NewsLoadInProgress) {
            _body = Center(child: CircularProgressIndicator());
          }
          if (state is NewsLoadSuccess) {
            final news = state.news;
            _body = SafeArea(
                child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: _newsTimeline(news),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                        controller: searchController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[500],
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: IconButton(
                          icon: Icon(Icons.search, color: Colors.blue),
                          onPressed: () {
                            _blocNews.add(NewsSearch(sourceId: widget.sourceId, search: searchController.text));
                          }),
                    ),
                  ),
                )
              ],
            ));
          }
          if (state is NewsLoadFailure) {
            _body = Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          }
          return _body;
        },
      ),
    );
  }

  Widget _newsTimeline(News news) {
    return Container(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: news.articles?.length,
          itemBuilder: (context, index) {
            Widget _content = SizedBox();
            if (news.articles != null) {
              _content = newsContent(news.articles[index]);
            }
            return _content;
          },
        ),
      ),
    );
  }

  Widget newsContent(Articles data) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: data.urlToImage != null
                ? Image.network(data.urlToImage)
                : Container(
                    width: double.maxFinite,
                    height: 150,
                    child: Placeholder(),
                  ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                data.sourceName != null
                    ? Text(
                        data.sourceName,
                        style: TextStyle(color: Colors.blue),
                      )
                    : Text(""),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 2.0),
                  child: data.title != null
                      ? Text(
                          data.title,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      : Text(""),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                  child: data.description != null
                      ? Text(
                          data.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 14),
                        )
                      : Text(""),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      // color: Colors.blue,
                      child: Expanded(
                        child: Material(
                          color: Colors.blue,
                          child: Container(
                            height: 40,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => NewsDetailScreen(
                                            title: data.title,
                                            url: data.url,
                                          )));
                                },
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        "Klik Untuk Membaca",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
