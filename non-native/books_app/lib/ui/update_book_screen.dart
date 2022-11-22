import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/book.dart';
import 'books_view_model.dart';

class UpdateBookScreen extends StatelessWidget {
  UpdateBookScreen(this.book, {super.key});

  final Book book;

  final BooksViewModel _booksViewModel = BooksViewModel();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = book.title;
    String author = book.author;
    int year = book.year;
    var lent = book.lent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply"),
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
                        initialValue: book.title,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(), labelText: 'Title'),
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
                        initialValue: book.author,
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
                        initialValue: book.year.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4)
                        ],
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(), labelText: 'Year'),
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
                              controlAffinity: ListTileControlAffinity.leading,
                              value: lent,
                              onChanged: (value) {
                                setState(() {
                                  lent = value ?? false;
                                });
                              });
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _booksViewModel.updateBook(Book(
                        id: book.id,
                        title: title,
                        author: author,
                        year: year,
                        lent: lent));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
