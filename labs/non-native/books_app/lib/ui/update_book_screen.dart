import 'package:books_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dao/persistence.dart';
import '../domain/book.dart';

class UpdateBookScreen extends StatefulWidget {
  const UpdateBookScreen({required this.book, super.key});

  final Book book;

  @override
  State<UpdateBookScreen> createState() => UpdateBookScreenState();
}

class UpdateBookScreenState extends State<UpdateBookScreen> {
  final _persistence = Persistence();
  late final Book _book = widget.book;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = _book.title;
    String author = _book.author;
    int year = _book.year;
    var lent = _book.lent;

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
                        initialValue: _book.title,
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
                        initialValue: _book.author,
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
                        initialValue: _book.year.toString(),
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
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;

                  var message = "Book updated";
                  var book = Book(
                      id: _book.id,
                      title: title,
                      author: author,
                      year: year,
                      lent: lent);

                  if (!await _persistence.updateBook(book)) {
                    message = "No server access! Please retry when online";
                  }
                  setState(() {});

                  if (!mounted) return;
                  showSnackBar(context, message);
                  Navigator.pop(context);
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
