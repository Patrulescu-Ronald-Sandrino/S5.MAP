import 'package:books_app/repository/BookRepository.dart';
import 'package:books_app/repository/BookRepositoryImpl.dart';
import 'package:flutter/material.dart';

import 'domain/Book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      theme: ThemeData(
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const BooksScreen(),
    );
  }
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final BookRepository _bookRepository = BookRepositoryImpl();

  // final books = [];

  @override
  Widget build(BuildContext context) {
    final books = _bookRepository.getBooks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];

          return ListTile(
            title: Text(book.title),
            // TODO: show book lent
            subtitle: Text(book.author),
            // TODO: click book => view book details
            trailing: Text(book.year.toString()), // tODO delete book icon + click + confirm dialog + notification
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBookPushed,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addBookPushed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          showSnackBar(String message) => {_showSnackBar(context, message)};
          
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Book'),
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: Add Book Form + error notification
                  ElevatedButton(
                      onPressed: () => {
                        setState((() => {
                          _bookRepository.addBook(Book.invalid),
                          showSnackBar('Book added'),
                        }))
                      },
                      child: const Text('Add'))
                ],
              ),
            ),
          );
        },
      ),
    );
    // throw UnimplementedError();
  }

  static void _showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
