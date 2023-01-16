import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/book.dart';

class Db {
  const Db();

  /// should the be called at the start of the application in order to set up the db
  static Future<void> init() async {
    final _ = await _getDatabase();
  }

  Future<List<Book>> getBooks() async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Query the table for all The Books.
    final List<Map<String, dynamic>> maps = await db.query('books');

    // Convert the List<Map<String, dynamic> into a List<Book>.
    return List.generate(maps.length, (index) => mapToBook(maps[index]));
  }

  Future<void> replaceBooks(List<Book> books) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    Batch batch = db.batch();
    batch.delete('books'); // delete all books
    
    for (var book in books) {
      var bookMap = book.toJson();
      bookMap['lent'] = book.lent ? 1 : 0;
      batch.insert(
        'books',
        bookMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<Book> getBook(String id) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    return await db.query('books', where: 'id = ?', whereArgs: [id], limit: 1).then((mapsList) {
      if (mapsList.isEmpty) throw Exception('Book not found');

      return mapToBook(mapsList.first);
    });
  }


  Future<void> addBook(Book book) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Insert the Book into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same book is inserted twice.
    //
    // In this case, replace any previous data.
    final bookMap = book.toJson();

    bookMap['lent'] = book.lent ? 1 : 0;

    await db.insert(
      'books',
      bookMap,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> updateBook(Book book) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Insert the Book into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same book is inserted twice.
    //
    // In this case, replace any previous data.
    final bookMap = book.toJson();
    bookMap['lent'] = book.lent ? 1 : 0;

    await db.update(
      'books',
      bookMap,
      where: 'id = ?',
      whereArgs: [book.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> deleteBook(String id) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Remove the Book from the database.
    await db.delete(
      'books',
      // Use a `where` clause to delete a specific book.
      where: "id = ?",
      // Pass the Book's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  //region privates
  static Future<Database> _getDatabase() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'books.db'),
      // When the database is first created, create a table to store book.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE books(id TEXT PRIMARY KEY, title TEXT, author TEXT, year INTEGER, lent INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  static Book mapToBook(Map<String, dynamic> map) {
    return Book(
        id: map['id'],
        title: map['title'],
        author: map['author'],
        year: map['year'],
        lent: map['lent'] == 1
    );
  }
  //endregion
}
