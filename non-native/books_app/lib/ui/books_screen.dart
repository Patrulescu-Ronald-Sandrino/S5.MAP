import 'package:books_app/ui/add_book_screen.dart';
import 'package:books_app/ui/books_view_model.dart';
import 'package:books_app/ui/view_book.dart';
import 'package:flutter/material.dart';

import '../dao/Response.dart';
import '../dao/persistence.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final BooksViewModel _booksViewModel =
      BooksViewModel(); // TODO END remove line
  final persistence = Persistence();
  var source = "";

  @override
  void initState() {
    super.initState();
    persistence.addListener((hasConnection) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final books = _booksViewModel.getBooks();

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
      body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {});
            });
          },
          child: FutureBuilder<Response>(
            future: persistence.getBooks(),
            builder: (context, snapshot) {
              List<Widget> children = [];

              if (snapshot.hasData) {
                var books = snapshot.data?.books ?? [];

                // Future(() async {
                //   setState(() => source = snapshot.data?.source ?? "");
                // });

                children = <Widget>[
                  Text("Connected to: ${snapshot.data?.source}"),
                  Flexible(
                      child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];

                      return ListTile(
                        title: Text(
                          '${book.title} (${book.year})',
                          style: TextStyle(
                              color: book.lent ? Colors.orange : Colors.black),
                        ),
                        subtitle: Text(book.author),
                        trailing: InkWell(
                          // allows to click on the child
                          child: Icon(
                            Icons.delete,
                            color: book.lent ? Colors.orange : Colors.black,
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
                                            _booksViewModel.deleteBook(book.id);
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      ViewBookScreen(book.id)))
                              .then((value) => setState(() {}));
                        },
                      );
                    },
                  ))
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[const Text("Error occurred!")];
              } else {
                children = <Widget>[const Text("Loading...")];
              }

              return Column(
                children: children,
              );
            },
          )),
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
          return const AddBookScreen();
          // final formKey = GlobalKey<FormState>();
          // String title = "";
          // String author = "";
          // int year = 0;
          //
          // return Scaffold(
          //   appBar: AppBar(
          //     title: const Text('Add Book'),
          //   ),
          //   body: Center(
          //     child: SizedBox(
          //       width: 300,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         // crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Form(
          //               key: formKey,
          //               child: Column(
          //                 children: [
          //                   TextFormField(
          //                     decoration: const InputDecoration(
          //                         border: UnderlineInputBorder(),
          //                         labelText: 'Title'),
          //                     validator: (value) {
          //                       if (value == null || value.isEmpty) {
          //                         return 'Please enter some text';
          //                       }
          //                       return null;
          //                     },
          //                     onChanged: (value) {
          //                       title = value;
          //                     },
          //                   ),
          //                   const SizedBox(height: 10),
          //                   TextFormField(
          //                     decoration: const InputDecoration(
          //                         border: UnderlineInputBorder(),
          //                         labelText: 'Author'),
          //                     validator: (value) {
          //                       if (value == null || value.isEmpty) {
          //                         return 'Please enter some text';
          //                       }
          //                       return null;
          //                     },
          //                     onChanged: (value) {
          //                       author = value;
          //                     },
          //                   ),
          //                   const SizedBox(height: 10),
          //                   TextFormField(
          //                     inputFormatters: [
          //                       FilteringTextInputFormatter.digitsOnly,
          //                       LengthLimitingTextInputFormatter(4)
          //                     ],
          //                     decoration: const InputDecoration(
          //                         border: UnderlineInputBorder(),
          //                         labelText: 'Year'),
          //                     validator: (value) {
          //                       if (value == null ||
          //                           value.isEmpty ||
          //                           int.tryParse(value) == null ||
          //                           int.parse(value) < 0) {
          //                         return 'Please enter a valid year';
          //                       }
          //                       return null;
          //                     },
          //                     onChanged: (value) {
          //                       year = int.tryParse(value) ?? year;
          //                     },
          //                   ),
          //                   const SizedBox(height: 10),
          //                   // checkboxlisttile without stateful widget https://stackoverflow.com/questions/58857826/flutter-checkbox-not-changing-updating-working
          //                   StatefulBuilder(
          //                     builder: (context, setState) {
          //                       return CheckboxListTile(
          //                           title: const Text('Lent'),
          //                           controlAffinity:
          //                           ListTileControlAffinity.leading,
          //                           value: _lent,
          //                           onChanged: (value) {
          //                             setState(() {
          //                               _lent = value ?? false;
          //                             });
          //                           });
          //                     },
          //                   ),
          //                 ],
          //               )),
          //           const SizedBox(height: 20),
          //           ElevatedButton(
          //               onPressed: () {
          //                 if (formKey.currentState!.validate()) {
          //                   setState((() => {
          //                     _bookRepository.addBook(Book(
          //                         id: 0,
          //                         title: title,
          //                         author: author,
          //                         year: year,
          //                         lent: _lent)),
          //                     showSnackBar(context, 'Book added'),
          //                   }));
          //                 }
          //               },
          //               child: const Text('Add')),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    ).then((_) {
      setState(() {});
    });
  }
}
