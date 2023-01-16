import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/book.dart';
import '../util/connectionStatusSingleton.dart';
import 'response.dart';
import 'implementation/api.dart';
import 'implementation/db.dart';


class Persistence {
  factory Persistence() { return _singleton; }

  void addListener(void Function(bool hasConnection) listener) {
    _connectionStatusSingleton.connectionChange.listen(listener);
  }

  Future<Response> getBooks() async {
    print("[Persistence.getBooks()] connection status = ${_connectionStatusSingleton.hasConnection}");
    if (_connectionStatusSingleton.hasConnection) {
      try {
        print("API GET books - START");
        var response = Response("API", await _synchronizeApiToDb());
        print("API GET books - SUCCESS. response = $response");
        return response;
      }
      catch (e) {
        print("API GET books - ERROR. e = $e");
        print("Resorting to DB GET books");
      }
    }

    print("DB GET BOOKS - START");
    var response = Response("DB", await _db.getBooks());
    print("DB GET books - SUCCESS. response = $response");
    return response;
  }

  Future<Book> getBook(String id) async {
    print("[Persistence.getBooks()] connection status = ${_connectionStatusSingleton.hasConnection}");
    if (_connectionStatusSingleton.hasConnection) {
      try {
        print("API GET book - START");
        var response = await _api.getBook(id);
        print("API GET book - SUCCESS. response = $response");
        return response;
      }
      catch (e) {
        print("API GET book - ERROR. e = $e");
        print("Resorting to DB GET book");
      }
    }

    print("DB GET BOOK - START");
    var response = await _db.getBook(id);
    print("DB GET book - SUCCESS. response = $response");
    return response;
  }

  /// returns whether the book was added to the API
  Future<bool> addBook(Book book) async {
    bool isBookAddedToServer = false;

    print("[Persistence.addBook()] connection status = ${_connectionStatusSingleton.hasConnection}");
    if (_connectionStatusSingleton.hasConnection) {
      try {
        print("API ADD book - START book = $book");
        book = await _api.addBook(book);
        isBookAddedToServer = true;
        print("API ADD book - SUCCESS book = $book");
      }
      catch (e) {
        print("API ADD book - ERROR. e = $e");
        print("Resorting to DB ADD book");
      }
    }

    print("DB ADD book - START book = $book");
    await _db.addBook(book);
    print("DB ADD book - SUCCESS");

    return isBookAddedToServer;
  }


  Future<bool> updateBook(Book book) async {
    print("[Persistence.updateBook()] connection status = ${_connectionStatusSingleton.hasConnection}");
    if (!_connectionStatusSingleton.hasConnection) return false;

    try {
      print("API UPDATE book - START book = $book");
      book = await _api.updateBook(book);
      print("API UPDATE book - SUCCESS book = $book");
    }
    catch (e) {
      print("API UPDATE book - ERROR. e = $e");
      return false;
    }

    print("DB UPDATE book - START book = $book");
    await _db.updateBook(book);
    print("DB UPDATE book - SUCCESS");
    return true;
  }

  /// @def: deletes the book if there's connection to the server <br>
  /// @return: whether the book was deleted
  Future<bool> deleteBook(String id) async {
    print("[Persistence.deleteBook()] connection status = ${_connectionStatusSingleton.hasConnection}");
    if (!_connectionStatusSingleton.hasConnection) return false;

    try {
      print("API DELETE book - START id = $id");
      await _api.deleteBook(id);
      print("API DELETE book - SUCCESS");
    }
    catch (e) {
      print("API DELETE book - ERROR. e = $e");
      return false;
    }

    print("DB DELETE book - START id = $id");
    await _db.deleteBook(id);
    print("DB DELETE book - SUCCESS");

    return true;
  }

  //region privates
  static final Persistence _singleton = Persistence._internal();
  Persistence._internal() { _connectionStatusSingleton.initialize(); }

  static const _api = Api();
  static const _db = Db();
  static final _connectionStatusSingleton = ConnectionStatusSingleton.getInstance();


  static Future<List<Book>> _synchronizeApiToDb() async {
    var dbBooksFuture = _db.getBooks();
    var apiBooksFuture = _api.getBooks();

    var dbBooks = await dbBooksFuture;
    var apiBooks = await apiBooksFuture;

    var booksToAdd = <Book>[];

    for (var dbBook in dbBooks) {
      if (apiBooks.none((apiBook) => apiBook.id == dbBook.id)) {
        booksToAdd.add(dbBook);
      }
      // if (!apiBooks.contains(dbBook)) {
      //   booksToAdd.add(dbBook);
      // }
    }

    List<Book> addedBooks = booksToAdd.isEmpty ? [] : await _api.addBooksAndGetBooks(booksToAdd);
    var allBooks = addedBooks + apiBooks;
    await _db.replaceBooks(allBooks);

    return allBooks;
  }
//endregion
}
