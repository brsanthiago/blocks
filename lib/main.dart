import 'package:blocks/ui/home/bloc/bloc.dart';
import 'package:blocks/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        body: BlocProvider(
          builder: (context) => HomeBloc(httpClient: http.Client())
            ..dispatch(Fetch()),
          child: HomePage(),
        ),
      ),
    );
  }
}
