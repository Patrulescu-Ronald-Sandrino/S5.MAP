package com.example.booksapp.view

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.booksapp.domain.Book
import com.example.booksapp.domain.IBookRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.count
import kotlinx.coroutines.launch
import javax.inject.Inject


@HiltViewModel
class BooksViewModel @Inject constructor(private val repo: IBookRepository) : ViewModel() {
    val books = repo.getBooksFromRoom()

    var book by mutableStateOf(Book(0, "", "", 0, false))
        private set

    fun deleteBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        repo.deleteBookFromRoom(book)
    }

    fun addBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        repo.addBookToRoom(book)
    }

    fun getBook(id: Int) = viewModelScope.launch(Dispatchers.IO) {
        book = repo.getBookFromRoom(id)
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
        repo.updateBookInRoom(book)
    }

    fun addSomeBooks() = viewModelScope.launch(Dispatchers.IO) {
        repo.addBookToRoom(Book(0, "Book 1", "Author 1", 1991, true))
        repo.addBookToRoom(Book(0, "Book 2", "Author 2", 1992, false))
        repo.addBookToRoom(Book(0, "Book 3", "Author 3", 1993, true))
        repo.addBookToRoom(Book(0, "Book 4", "Author 4", 1994, false))
        println("called")
    }
}