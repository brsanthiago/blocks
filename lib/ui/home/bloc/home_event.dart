import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class HomeEvent extends Equatable {

  HomeEvent([List tmp = const []]) : super(tmp);
}

class Fetch extends HomeEvent {
  @override
  String toString() => 'Fetch';
}