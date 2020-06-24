import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:binar/model/news.dart';

abstract class NewsSourceState extends Equatable {
  const NewsSourceState();

  @override
  List<Object> get props => [];
}

class NewsSourceInitial extends NewsSourceState {}

class NewsSourceLoadInProgress extends NewsSourceState {}

class NewsSourceLoadSuccess extends NewsSourceState {
  final Source source;

  const NewsSourceLoadSuccess({@required this.source}) : assert(source != null);

  @override
  List<Object> get props => [source];
}

class NewsSourceLoadFailure extends NewsSourceState {}
