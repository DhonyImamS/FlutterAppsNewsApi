import 'package:binar/bloc/news_source.dart';
import 'package:binar/repository/news_api_client.dart';
import 'package:binar/repository/news_repository.dart';
import 'package:binar/screen/news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

class NewsSourceScreen extends StatefulWidget {
  final String category;
  NewsSourceScreen({this.category});
  @override
  _NewsSourceScreenState createState() => _NewsSourceScreenState();
}

class _NewsSourceScreenState extends State<NewsSourceScreen> {
  final NewsRepository newsRepository = NewsRepository(
    newsApiClient: NewsApiClient(
      httpClient: http.Client(),
    ),
  );
  NewsSourceBloc _blocSource;
  final RandomColor _randomColor = RandomColor();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _blocSource = NewsSourceBloc(newsRepository: newsRepository);
    _blocSource.add(NewsSourceRequested(category: widget.category));
    //_blocSource.add(NewsSourceSearch(category: widget.category, search: 'a'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Source"),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsSourceBloc, NewsSourceState>(
        bloc: _blocSource,
        builder: (context, state) {
          Widget _body;
          if (state is NewsSourceInitial) {
            _body = Text("Start");
          }
          if (state is NewsSourceLoadInProgress) {
            _body = Center(child: CircularProgressIndicator());
          }
          if (state is NewsSourceLoadSuccess) {
            final source = state.source;
            _body = Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: source.newsSource.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsListScreen(
                                sourceId: source.newsSource[index].id,
                              ),
                            ),
                          );
                          print("Source ku" + source.newsSource[index].id);
                        },
                        child: Card(
                          color: _randomColor.randomColor(),
                          child: Center(
                            child: Text(
                              source.newsSource[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
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
                            _blocSource.add(NewsSourceSearch(category: widget.category, search: searchController.text));
                          }),
                    ),
                  ),
                )
              ],
            );
          }
          if (state is NewsSourceLoadFailure) {
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
}
