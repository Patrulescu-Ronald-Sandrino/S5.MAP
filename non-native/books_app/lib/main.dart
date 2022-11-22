import 'package:flutter/material.dart';

import 'domain/book.dart';

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
  final  _books = [
    Book(1, 'The Hobbit', 'J.R.R. Tolkien', 1937, false),
    Book(2, 'The Lord of the Rings', 'J.R.R. Tolkien', 1954, true),
    Book(3, 'The Silmarillion', 'J.R.R. Tolkien', 1977, false),
    Book(4, 'The Chronicles of Narnia', 'C.S. Lewis', 1950, true),
    Book(5, 'The Lion, the Witch and the Wardrobe', 'C.S. Lewis', 1950, false),
    Book(6, 'The Magician\'s Nephew', 'C.S. Lewis', 1955, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books'),),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            title: Text(book.title), // TODO: show book lent
            subtitle: Text(book.author), // TODO: click book => view book details
            trailing: Text(book.year.toString()), // tODO delete book + click
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
          return Scaffold(
            appBar: AppBar(title: const Text('Add Book'),),
            body: const Text('Add Book'), // TODO: Add Book Form
          );
        },
      ),
    );
    // throw UnimplementedError();
  }
}