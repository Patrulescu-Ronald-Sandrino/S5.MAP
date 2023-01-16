import 'package:books_app/dao/persistence.dart';
import 'package:books_app/ui/update_book_screen.dart';
import 'package:flutter/material.dart';

import '../domain/book.dart';

class ViewBookScreen extends StatefulWidget {
  const ViewBookScreen(this.id, {super.key});

  final String id;

  @override
  State<ViewBookScreen> createState() => _ViewBookScreenState();
}

class _ViewBookScreenState extends State<ViewBookScreen> {
  final _persistence = Persistence();

  @override
  void initState() {
    super.initState();

    // _getBook = _persistence.getBook(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View book'),
      ),
      body: FutureBuilder<Book>(
        future: _persistence.getBook(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          else {
            final book = snapshot.data!;
            return Center(
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
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => UpdateBookScreen(book: book),
                          ),
                        )
                            .then((value) => setState(() {}));
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
