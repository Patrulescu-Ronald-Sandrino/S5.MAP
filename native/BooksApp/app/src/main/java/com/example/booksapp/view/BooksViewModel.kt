package com.example.booksapp.view

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {
    private var _books = flowOf(listOf(
        Book(1, "Book 1", "Author 1", 1991, true),
        Book(2, "Book 2", "Author 2", 1992, false),
        Book(3, "Book 3", "Author 3", 1993, true),
        Book(4, "Book 4", "Author 4", 1994, false),
//        Book(5, "Book 5", "Author 5", 1995, true),
    ))
    val books = _books

    fun deleteBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        _books = flowOf(_books.first().filterNot { it.id == book.id })
    }

    fun addBook(book: Book) = viewModelScope.launch(Dispatchers.IO) { // TODO: fix after add, the list is not updated
        _books = flowOf(_books.first().plus(book))
    }
}