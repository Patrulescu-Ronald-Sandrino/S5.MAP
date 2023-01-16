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

    return booksIterable.map((book) => Book.fromJson(book)).toList();
  }

  Future<Book> getBook(String id) async {
    final response = await http.get(_getUrl(id));

    if (response.statusCode != 200) throw Exception('Failed to load book');

    return Book.fromJson(json.decode(response.body));
  }

  Future<List<Book>> addBooksAndGetBooks(List<Book> booksToAdd) async {
    final response = await http.post(_getUrl('add-all-and-get'),
        headers: headersSendAcceptJson, body: json.encode(booksToAdd));

    if (response.statusCode != 200) {
      debugPrint(
          "Failed to add books.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to add books');
    }

    Iterable booksIterable = json.decode(response.body);

    return booksIterable.map((book) => Book.fromJson(book)).toList();
  }

  Future<Book> addBook(Book book) async {
    final response = await http.post(_getUrl(''),
        headers: headersSendAcceptJson, body: json.encode(book));

    if (response.statusCode != 201) {
      debugPrint(
          "Failed to add book.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to add book');
    }

    return Book.fromJson(json.decode(response.body));
  }

  Future<Book> updateBook(Book book) async {
    final response = await http.put(_getUrl(''),
        headers: headersSendAcceptJson, body: json.encode(book));

    if (response.statusCode != 200) {
      debugPrint(
          "Failed to update book.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to update book');
    }

    return Book.fromJson(json.decode(response.body));
  }

  Future<void> deleteBook(String id) async {
    final response = await http.delete(_getUrl(id));

    if (response.statusCode != 200) {
      debugPrint(
          "Failed to delete book.\nresponse.reasonPhrase = ${response.reasonPhrase}\nresponse.body = ${response.body}");
      throw Exception('Failed to delete book');
    }
  }

  //region private
  static const headersSendJson = {'Content-Type': 'application/json'};
  static const headersSendAcceptJson = {
    "Accept": "application/json",
    ...headersSendJson,
  };

  static Uri _getUrl(String path) {
    return Uri.parse('https://10.0.2.2:7235/Books/$path');
  }
  //endregion
}
