import 'package:binar/screen/news_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:binar/model/news.dart';
import 'package:random_color/random_color.dart';

class HomeScreen extends StatelessWidget {
  final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: NewsCategory.values.length,
        itemBuilder: (BuildContext context, int index) => Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsSourceScreen(
                    category: getCategory(NewsCategory.values[index]),
                  ),
                ),
              );
            },
            child: Card(
              color: _randomColor.randomColor(),
              child: Center(
                child: Text(
                  getCategoryText(NewsCategory.values[index]),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
