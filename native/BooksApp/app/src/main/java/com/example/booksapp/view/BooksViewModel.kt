package com.example.booksapp.view

import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import javax.inject.Inject


data class BookState(
    val lazyListState: LazyListState,
    val book: Book = Book(0, "", "", 0, false),
    val books: List<Book> = listOf(
        Book(1, "Book 1", "Author 1", 1991, true),
        Book(2, "Book 2", "Author 2", 1992, false),
        Book(3, "Book 3", "Author 3", 1993, true),
        Book(4, "Book 4", "Author 4", 1994, false),
        //            Book(5, "Book 5", "Author 5", 1995, true),)
    )
)

fun getBooks(): List<Book> {
    val books = mutableListOf<Book>()

    for (i in 1..4) {
        books.add(Book(i, "Book $i", "Author $i", 1990 + i, i % 2 == 1))
    }

    return books
}

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {

    var uiState by mutableStateOf(BookState(LazyListState()))
        private set

    var books by mutableStateOf(getBooks())


    fun deleteBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        books = books.toMutableList().also { it -> it.removeIf { it.id == book.id } }
//        books.removeIf { it.id == book.id }
//        uiState = uiState.copy(books = uiState.books.toMutableList().also { books -> books.removeIf { it.id == book.id } })
    }

    // TODO: fix add
    fun addBook(book: Book) /*= viewModelScope.launch(Dispatchers.IO)*/ {
        val newBook = book.copy(id = uiState.books.maxOfOrNull { it.id }?.plus(1) ?: 1)
        books = books + listOf(newBook)
//        val newBooks = books.toMutableList() + listOf(newBook)
//        books.clear()
//        books.addAll(newBooks)
//        uiState = uiState.copy(books = uiState.books.toMutableList() + listOf(newBook))
        // inainte de W5 100%
        // inainte de W6 75%
        // inainte de W7 50%
        // inainte de W8 25%
        // inainte de W9 0%
    }

    var book by mutableStateOf(Book(0, "", "", 0, false))
        private set

    fun getBook(id: Int) { // TODO: add/remove = viewModelScope.launch(Dispatchers.IO)
        throw NotImplementedError()
//        book = itemsImpl.first { it.id == id }
    }

    fun updateTitle(title: String) {
        book = book.copy(title = title)
    }

    fun updateAuthor(author: String) {
        book = book.copy(author = author)
    }

    fun updateYear(year: Int) {
        book = book.copy(year = year)
    }

    fun updateLent(lent: Boolean) {
        book = book.copy(lent = lent)
    }

    fun updateBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        throw NotImplementedError()
//        println("Before")
//        println("itemsImpl = $itemsImpl")
//        println("items = $items")
//
//        val index = itemsImpl.indexOfFirst { it.id == book.id }
//        if (index != -1) {
//            itemsImpl[index] = book
//
//            println("After")
//            println("itemsImpl = $itemsImpl")
//            println("items = $items")
//        }
    }
}