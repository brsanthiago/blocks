
import 'package:blocks/domain/model/book.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {
  HomeState([List tmp = const []]) : super(tmp);
}

class HomeUninitialized extends HomeState {
  @override
  String toString() => "HomeUninitialized";
}

class HomeLoaded extends HomeState {
  final List<Book> books;
  final bool hasReachedMax;

  HomeLoaded({
    this.books,
    this.hasReachedMax,
  }) : super([books, hasReachedMax]);

  HomeLoaded copyWith({
    List<Book> books,
    bool hasReachedMax,
  }) {
    return HomeLoaded(
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => "HomeStateSuccess";
}

class HomeError extends HomeState {
  final String error;

  HomeError({
    @required this.error
  });

  @override
  String toString() => "HomeStateError";
}