package com.example.booksapp.view

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {
    private val _books = MutableStateFlow(
        listOf(
            Book(1, "Book 1", "Author 1", 1991, true),
            Book(2, "Book 2", "Author 2", 1992, false),
            Book(3, "Book 3", "Author 3", 1993, true),
            Book(4, "Book 4", "Author 4", 1994, false),
//            Book(5, "Book 5", "Author 5", 1995, true),
        )
    )
    val books = _books.asStateFlow()

    fun deleteBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        _books.update { books ->
            books.filter { it.id != book.id }
        }
    }

    fun addBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        println(_books.value)
        _books.update { books ->
            books + book.copy(id = books.maxOfOrNull { it.id }?.plus(1) ?: 1)
        }
        println(_books.value)
    }
}