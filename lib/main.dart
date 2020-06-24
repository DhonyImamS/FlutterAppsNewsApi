import 'package:binar/bloc/simple_bloc_delegate.dart';
import 'package:binar/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // final NewsRepository newsRepository = NewsRepository(
  //   newsApiClient: NewsApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
