

import '../domain/Book.dart';

abstract class BookRepository {
  List<Book> getBooks();
  Book getBook(int id);
  void addBook(Book book);
  void updateBook(Book book);
  void deleteBook(int id);
}