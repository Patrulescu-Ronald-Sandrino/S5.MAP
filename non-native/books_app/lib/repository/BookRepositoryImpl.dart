

import 'package:books_app/domain/Book.dart';
import 'package:books_app/repository/BookRepository.dart';

class BookRepositoryImpl implements BookRepository {
  final _books = [
    const Book(id: 1, title: 'The Hobbit', author: 'J.R.R. Tolkien', year: 1937, lent: false),
    const Book(id: 2, title: 'The Lord of the Rings', author: 'J.R.R. Tolkien', year: 1954, lent: true),
    const Book(id: 3, title: 'The Silmarillion', author: 'J.R.R. Tolkien', year: 1977, lent: false),
    const Book(id: 4, title: 'The Chronicles of Narnia', author: 'C.S. Lewis', year: 1950, lent: true),
    const Book(id: 5, title: 'The Lion, the Witch and the Wardrobe', author: 'C.S. Lewis', year: 1950, lent: false),
    const Book(id: 6, title: 'The Magician\'s Nephew', author: 'C.S. Lewis', year: 1955, lent: false)
  ];

  @override
  void addBook(Book book) {
    var newId = _books.map((book) => book.id).reduce((value, element) => value > element ? value : element) + 1;
    _books.add(book.copyWith(id: newId));
  }

  @override
  void deleteBook(int id) {
    _books.removeWhere((book) => book.id == id);
  }

  @override
  /// returns Book.empty if the book is not found
  Book getBook(int id) {
    return _books.firstWhere((book) => book.id == id, orElse: () => Book.invalid);
  }

  @override
  List<Book> getBooks() {
    return _books.toList();
  }

  @override
  void updateBook(Book book) {
    var index = _books.indexWhere((element) => element.id == book.id);

    if (index != -1) {
      _books[index] = book;
    }
  }
}