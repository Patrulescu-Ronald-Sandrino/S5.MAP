import '../domain/book.dart';
import '../util/connectionStatusSingleton.dart';
import 'Response.dart';
import 'implementation/api.dart';
import 'implementation/db.dart';

class Persistence {
  Persistence() {
    _connectionStatusSingleton.initialize();
  }

  void addListener(void Function(bool hasConnection) listener) {
    _connectionStatusSingleton.connectionChange.listen(listener);
  }

  Future<Response> getBooks() async {
    // TODO: remove commented out try/catch variant after trying it out
    // TODO: try it out along with all other implemented persistence methods
    // try {
    //   return Response("API", await _synchronizeApiToDb());
    // } catch (e) {
    //   debugPrint(e.toString());
    //   print("API GET books is NOT responding. Getting books from DB");
    //   return Response("DB", await _db.getBooks());
    // }
    print("connection status = ${_connectionStatusSingleton.hasConnection}");
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

  /// returns whether the book was added to the API
  Future<bool> addBook(Book book) async {
    var isBookNew = true;

    print("connection status = ${_connectionStatusSingleton.hasConnection}");
    if (_connectionStatusSingleton.hasConnection) {
      try {
        print("API ADD book - START book = $book");
        book = await _api.addBook(book);
        isBookNew = false;
        print("API ADD book - SUCCESS book = $book");
      }
      catch (e) {
        print("API ADD book - ERROR. e = $e");
        print("Resorting to DB ADD book");
      }
    }

    print("DB ADD book - START book = $book");
    await _db.addBook(book, isBookNew);
    print("DB ADD book - SUCCESS");

    return !isBookNew;
    // TODO call setState() in the UI
    // TODO if false, notify that is offline and the operation will be performed when back online
  }

  // TODO update

  /// @def: deletes the book if there's connection to the server <br>
  /// @return: whether the book was deleted
  Future<bool> deleteBook(int id) async {
    print("connection status = ${_connectionStatusSingleton.hasConnection}");
    if (!_connectionStatusSingleton.hasConnection) return false;

    try {
      print("API DELETE book - START id = $id");
      await _api.deleteBook(id);
      print("API DELETE book - SUCCESS");
    }
    catch (e) {
      print("API DELETE book - ERROR. e = $e");
      rethrow;
    }

    print("DB DELETE book - START id = $id");
    await _db.deleteBook(id);
    print("DB DELETE book - SUCCESS");

    return true;
    // TODO call setState() in the UI
    // TODO if false, notify that the action could not be performed while offline
  }

  //region privates
  static const _api = Api();
  static const _db = Db();
  final _connectionStatusSingleton = ConnectionStatusSingleton.getInstance();


  static Future<List<Book>> _synchronizeApiToDb() async {
    var dbBooks = await _db.getBooks();
    var booksToAdd = (dbBooks).where((element) => element.id == 0).toList();
    var apiBooks = await (booksToAdd.isEmpty ? _api.getBooks() : _api.addBooksAndGetBooks(booksToAdd));

    await _db.addBooks(apiBooks);
    var newDbBooks = await _db.getBooks(); // TODO END remove this line

    return apiBooks;
  }
//endregion
}
