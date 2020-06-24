import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsRequested extends NewsEvent {
  final String sourceId;

  const NewsRequested({@required this.sourceId}) : assert(sourceId != null);

  @override
  List<Object> get props => [sourceId];
}

class NewsSearch extends NewsEvent {
  final String search;
  final String sourceId;
  const NewsSearch({this.search, this.sourceId}) : assert(search != null);

  @override
  List<Object> get props => [search, sourceId];
}
