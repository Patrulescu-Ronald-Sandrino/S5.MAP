import 'package:books_app/repository/BookRepository.dart';
import 'package:books_app/repository/BookRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var _lent = false;

  @override
  Widget build(BuildContext context) {
    final books = _bookRepository.getBooks();

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Books ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                  text: '(',
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              TextSpan(
                  text: 'lent books are in orange',
                  style: TextStyle(fontSize: 14, color: Colors.orange)),
              TextSpan(
                  text: ')',
                  style: TextStyle(fontSize: 14, color: Colors.black)),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];

          return ListTile(
            title: Text(
              '${book.title} (${book.year})',
              style: TextStyle(color: book.lent ? Colors.black : Colors.orange),
            ),
            subtitle: Text(book.author),
            trailing: InkWell( // allows to click on the child
              child: Icon(
                Icons.delete,
                color: book.lent ? Colors.black : Colors.orange,
                semanticLabel: 'Delete',
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete book'),
                        content: const Text(
                            'Are you sure you want to delete this book?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                _bookRepository.deleteBook(book.id);
                              });
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    });
              },
            ),
            onTap: () {
              // TODO: click book => view book details => edit book
              print('TODO: view book details');
            },
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
          final formKey = GlobalKey<FormState>();
          String title = "";
          String author = "";
          int year = 0;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Book'),
            ),
            body: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Title'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                title = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Author'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                author = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4)
                              ],
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Year'),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.tryParse(value) == null ||
                                    int.parse(value) < 0) {
                                  return 'Please enter a valid year';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                year = int.tryParse(value) ?? year;
                              },
                            ),
                            const SizedBox(height: 10),
                            // checkboxlisttile without stateful widget https://stackoverflow.com/questions/58857826/flutter-checkbox-not-changing-updating-working
                            StatefulBuilder(
                              builder: (context, setState) {
                                return CheckboxListTile(
                                    title: const Text('Lent'),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: _lent,
                                    onChanged: (value) {
                                      setState(() {
                                        _lent = value ?? false;
                                      });
                                    });
                              },
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState((() => {
                                  _bookRepository.addBook(Book(
                                      id: 0,
                                      title: title,
                                      author: author,
                                      year: year,
                                      lent: _lent)),
                                  showSnackBar('Book added'),
                                }));
                          }
                        },
                        child: const Text('Add')),
                  ],
                ),
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
