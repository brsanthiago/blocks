import 'package:blocks/domain/model/book.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BookWidget extends StatelessWidget {
  final Book book;
  BookWidget({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                book.volumeInfo.imageLinks.smallThumbnail,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              height: 180,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 15)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    book.volumeInfo.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  Text(
                    book.volumeInfo.publisher,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                    maxLines: 2,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[300],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
