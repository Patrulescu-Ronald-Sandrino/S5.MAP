

import '../domain/book.dart';

abstract class BooksRepository {
  List<Book> getBooks();
  Book getBook(int id);
  void addBook(Book book);
  void updateBook(Book book);
  void deleteBook(int id);
}