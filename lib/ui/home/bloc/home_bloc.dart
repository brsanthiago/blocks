import 'package:bloc/bloc.dart';
import 'package:blocks/domain/model/BookResponse.dart';
import 'package:blocks/domain/model/book.dart';
import 'package:blocks/ui/home/bloc/home_event.dart';
import 'package:blocks/ui/home/bloc/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final http.Client httpClient;

  HomeBloc({@required this.httpClient});

  @override
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is HomeUninitialized) {
          final posts = await _fetchBooks(0, 20);
          yield HomeLoaded(books: posts, hasReachedMax: false);
          return;
        }
        if (currentState is HomeLoaded) {
          final posts =
          await _fetchBooks((currentState as HomeLoaded).books.length, 20);
          yield posts.isEmpty
              ? (currentState as HomeLoaded).copyWith(hasReachedMax: true)
              : HomeLoaded(
            books: (currentState as HomeLoaded).books + posts,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield HomeError();
      }
    }
  }

  bool _hasReachedMax(HomeState state) =>
      state is HomeLoaded && state.hasReachedMax;

  Future<List<Book>> _fetchBooks(int startIndex, int limit) async {
    final String path = "https://www.googleapis.com/books/v1/volumes";
    final response = await httpClient.get(
        '$path?q=Myths&startIndex=$startIndex&maxResults=$limit');
    if (response.statusCode == 200) {
      var json = converter.jsonDecode(response.body);
      var bookResponse = BookResponse.fromJson(json);
      return bookResponse.items;

    } else {
      throw Exception('error fetching posts');
    }
  }
}
