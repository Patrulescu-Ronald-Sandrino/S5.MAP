import '../domain/book.dart';

class Response {
  String source;
  List<Book> books;

  Response(this.source, this.books);
}