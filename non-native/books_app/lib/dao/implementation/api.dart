import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../domain/book.dart';

class Api {
  const Api();

  Future<List<Book>> getBooks() async {
    final response = await http.get(_getUrl(''));

    if (response.statusCode != 200) throw Exception('Failed to load books');

    Iterable booksIterable = json.decode(response.body);

    // return _synchronizeApiToDb(books); // TODO: move this to DAO
    return booksIterable.map((book) => Book.fromJson(book)).toList();
  }

  Future<List<Book>> addBooksAndGetBooks(List<Book> booksToAdd) async {
    final response = await http.post(_getUrl('add-all-and-get-all'), headers: {"Accept": "application/json", "content-type": "application/json",}, body: json.encode(booksToAdd));

    if (response.statusCode != 200) {
      debugPrint("Failed to add books.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to add books');
    }

    Iterable booksIterable = json.decode(response.body);

    return booksIterable.map((book) => Book.fromJson(book)).toList();
  }

  Future<Book> addBook(Book book) async {
    final response = await http.post(_getUrl(''), body: json.encode(book));

    if (response.statusCode != 200) {
      debugPrint("Failed to add book.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to add book');
    }

    return Book.fromJson(json.decode(response.body));
  }

  // TODO update


  Future<void> deleteBook(int id) async {
    final response = await http.delete(_getUrl('$id'));
    if (response.statusCode != 200) {
      debugPrint("Failed to delete book.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to delete book');
    }
  }

  //region private
  static Uri _getUrl(String path) {
    return Uri.parse('https://10.0.2.2:7235/Books/$path');
  }
//endregion
}
