import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/book.dart';
import '../util.dart';
import 'books_view_model.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final BooksViewModel _booksViewModel = BooksViewModel();
  var _lent = false;

  @override
  Widget build(BuildContext context) {
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
                        _booksViewModel.addBook(Book(
                            id: 0,
                            title: title,
                            author: author,
                            year: year,
                            lent: _lent)),
                      }));
                    }
                    showSnackBar(context, 'Book added');
                  },
                  child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
