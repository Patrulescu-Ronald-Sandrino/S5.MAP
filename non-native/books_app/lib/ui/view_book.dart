import 'package:books_app/ui/update_book_screen.dart';
import 'package:flutter/material.dart';

import 'books_view_model.dart';

class ViewBookScreen extends StatefulWidget {
  const ViewBookScreen(this.id, {super.key});

  final int id;

  @override
  State<ViewBookScreen> createState() => _ViewBookScreenState();
}

class _ViewBookScreenState extends State<ViewBookScreen> {
  final BooksViewModel _booksViewModel = BooksViewModel();

  @override
  Widget build(BuildContext context) {
    final book = _booksViewModel.getBook(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View book'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Title: ${book.title}'),
              const SizedBox(height: 10),
              Text('Author: ${book.author}'),
              const SizedBox(height: 10),
              Text('Year: ${book.year}'),
              const SizedBox(height: 10),
              Text('Lent: ${book.lent}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateBookScreen(book),
                    ),
                  ).then((value) => setState(() {}));
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
