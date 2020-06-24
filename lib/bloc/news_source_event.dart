import 'package:equatable/equatable.dart';

abstract class NewsSourceEvent extends Equatable {
  const NewsSourceEvent();
}

class NewsSourceRequested extends NewsSourceEvent {
  final String category;
  const NewsSourceRequested({this.category}) : assert(category != null);

  @override
  List<Object> get props => [category];
}

class NewsSourceSearch extends NewsSourceEvent {
  final String search;
  final String category;
  const NewsSourceSearch({this.search, this.category}) : assert(search != null);

  @override
  List<Object> get props => [search, category];
}
