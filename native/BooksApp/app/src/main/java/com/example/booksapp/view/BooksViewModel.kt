package com.example.booksapp.view

import androidx.lifecycle.ViewModel
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import java.util.concurrent.Flow
import javax.inject.Inject

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {
    private var _books: MutableList<Book> = mutableListOf(
        Book(1, "Book 1", "Author 1", 1991, true),
        Book(2, "Book 2", "Author 2", 1992, false),
        Book(3, "Book 3", "Author 3", 1993, true),
        Book(4, "Book 4", "Author 4", 1994, false),
//        Book(5, "Book 5", "Author 5", 1995, true),
    )
    val books: List<Book> get() = _books

    fun deleteBook(book: Book) {
        _books.remove(book)
    }

    fun addBook(book: Book) { // TODO: fix after add, the list is not updated
        _books.add(book.copy(id = _books.maxOfOrNull { it.id }?.plus(1) ?: 1))
    }
}