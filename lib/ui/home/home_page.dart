import 'package:blocks/domain/model/book.dart';
import 'package:blocks/ui/home/bloc/bloc.dart';
import 'package:blocks/ui/widget/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  List<String> categories = [
    "Typography",
    "Myths",
    "Pothography",
    "Science",
  ];
  List<String> books = [
    "Under water Photography",
    "Architerute Photography",
    "Skye line",
  ];

  int _categorySelected = 0;
  String query;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _scrollController.addListener(_onScroll);
    query = categories[_categorySelected];
    _bloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext bContext, HomeState state) {
        if (state is HomeLoaded) {
          if (state.books.isEmpty) {
            return Center(
              child: Text("no books"),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 48, left: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            "Browser",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Recommended",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                            inherit: true,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext bContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: GestureDetector(
                              child: Chip(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                backgroundColor: index == _categorySelected
                                    ? Colors.blue
                                    : Colors.grey[350],
                                label: Text(
                                  categories[index],
                                  style: TextStyle(
                                      color: index == _categorySelected
                                          ? Colors.white
                                          : Colors.grey[500]),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _categorySelected = index;
                                  query = categories[_categorySelected];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.hasReachedMax
                              ? state.books.length
                              : state.books.length + 1,
                          controller: _scrollController,
                          itemBuilder: (BuildContext bContext, int index) {
                            final Book book = state.books[index];
                            return BookWidget(book: book);
                          }),
                    )
                  ],
                ),
              ),
            );
          }
        } else if (state is HomeUninitialized) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading books"),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text("failed to fetch books"),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.dispatch(Fetch());
    }
  }
}
