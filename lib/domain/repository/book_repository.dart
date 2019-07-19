import 'dart:convert' as converter;

import 'package:blocks/domain/model/BookResponse.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
class BookRepository {


  final String path = "https://www.googleapis.com/books/v1/volumes?q=";

  Future<BookResponse> findBy({@required String query}) async {
      var mQuery = query != null ? query : "Myths";

      final response = await http.get("$path$mQuery");
      if (response.statusCode == 200) {

        var json = converter.jsonDecode(response.body);
        return BookResponse.fromJson(json);
       } else {
        throw Exception('error fetching posts');
      }

  }
}
