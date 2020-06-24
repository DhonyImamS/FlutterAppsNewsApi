import 'package:binar/model/news.dart';
import 'package:binar/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'news_source_event.dart';
import 'news_source_state.dart';

class NewsSourceBloc extends Bloc<NewsSourceEvent, NewsSourceState> {
  final NewsRepository newsRepository;

  NewsSourceBloc({@required this.newsRepository}) : assert(newsRepository != null);

  @override
  NewsSourceState get initialState => NewsSourceInitial();

  @override
  Stream<NewsSourceState> mapEventToState(NewsSourceEvent event) async* {
    if (event is NewsSourceRequested) {
      yield* _mapNewsSourceRequestedToState(event);
    } else if (event is NewsSourceSearch) {
      yield* _mapNewsSourceSearchToState(event);
    }
  }

  Stream<NewsSourceState> _mapNewsSourceRequestedToState(NewsSourceRequested event) async* {
    yield NewsSourceLoadInProgress();
    try {
      final Source source = await newsRepository.getNewsSource(event.category);
      yield NewsSourceLoadSuccess(source: source);
    } catch (_) {
      yield NewsSourceLoadFailure();
    }
  }

  Stream<NewsSourceState> _mapNewsSourceSearchToState(NewsSourceSearch event) async* {
    yield NewsSourceLoadInProgress();
    try {
      final Source source = await newsRepository.getNewsSource(event.category);
      if (event.search != null || event.search.trim() != "") {
        List<NewsSource> newsSource = source.newsSource.where((result) => result.name.toLowerCase().contains(event.search.toLowerCase())).toList();
        final sourceFiltered = Source(newsSource: newsSource);
        yield NewsSourceLoadSuccess(source: sourceFiltered);
      }
    } catch (_) {
      yield state;
    }
  }
}
