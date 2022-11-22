

import 'package:books_app/repository/books_repository_impl.dart';

import '../domain/book.dart';
import '../repository/books_repository.dart';

// dart singleton https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
class BooksViewModel {
  final BooksRepository _booksRepository = BooksRepositoryImpl();

  static final BooksViewModel _booksViewModel = BooksViewModel._internal();

  factory BooksViewModel() => _booksViewModel;

  BooksViewModel._internal();

  List<Book> getBooks() => _booksRepository.getBooks();
  Book getBook(int id) => _booksRepository.getBook(id);
  void addBook(Book book) => _booksRepository.addBook(book);
  void updateBook(Book book) => _booksRepository.updateBook(book);
  void deleteBook(int id) => _booksRepository.deleteBook(id);
}