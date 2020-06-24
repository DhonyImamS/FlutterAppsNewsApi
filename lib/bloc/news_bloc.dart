import 'package:binar/bloc/news.dart';
import 'package:binar/model/news.dart';
import 'package:binar/repository/news_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository}) : assert(newsRepository != null);

  @override
  NewsState get initialState => NewsInitial();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsRequested) {
      yield* _mapNewsRequestedToState(event);
    } else if (event is NewsSearch) {
      yield* _mapNewsSearchToState(event);
    }
  }

  Stream<NewsState> _mapNewsRequestedToState(NewsRequested event) async* {
    yield NewsLoadInProgress();
    try {
      final News news = await newsRepository.getNews(event.sourceId);
      yield NewsLoadSuccess(news: news);
    } catch (_) {
      yield NewsLoadFailure();
    }
  }

  Stream<NewsState> _mapNewsSearchToState(NewsSearch event) async* {
    yield NewsLoadInProgress();
    try {
      final News source = await newsRepository.getNews(event.sourceId);
      if (event.search != null || event.search.trim() != "") {
        List<Articles> newsSource = source.articles.where((result) => result.title.toLowerCase().contains(event.search.toLowerCase())).toList();
        final sourceFiltered = News(articles: newsSource);
        yield NewsLoadSuccess(news: sourceFiltered);
      }
    } catch (_) {
      yield state;
    }
  }
}
