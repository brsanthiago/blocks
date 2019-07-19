import 'package:blocks/domain/model/book.dart';

class BookResponse {
  String kind;
  int totalItems;
  List<Book> items;

  BookResponse({this.kind, this.totalItems, this.items});

  BookResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      items = new List<Book>();
      json['items'].forEach((v) {
        items.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['totalItems'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}