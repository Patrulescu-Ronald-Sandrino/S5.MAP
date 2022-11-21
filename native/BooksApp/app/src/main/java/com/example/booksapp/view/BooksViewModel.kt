package com.example.booksapp.view

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshots.SnapshotStateList
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {
    val itemLiveData: LiveData<SnapshotStateList<Book>>
        get() = items

    private val itemsImpl = mutableStateListOf(
        Book(1, "Book 1", "Author 1", 1991, true),
        Book(2, "Book 2", "Author 2", 1992, false),
        Book(3, "Book 3", "Author 3", 1993, true),
        Book(4, "Book 4", "Author 4", 1994, false),
//            Book(5, "Book 5", "Author 5", 1995, true),
    )
    private val items = MutableLiveData<SnapshotStateList<Book>>(itemsImpl)

    fun deleteBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        itemsImpl.removeIf { it.id == book.id }
        items.postValue(itemsImpl)
    }

    // TODO: fix add
    fun addBook(book: Book) = viewModelScope.launch(Dispatchers.IO) {
        val newBook = book.copy(id = itemsImpl.maxOfOrNull { it.id }?.plus(1) ?: 1)
        println("add book")

        println("Before")
        println("itemsImpl = $itemsImpl")
        println("items = $items")

        // inainte de W5 100%
        // inainte de W6 75%
        // inainte de W7 50%
        // inainte de W8 25%
        // inainte de W9 0%
        itemsImpl.add(newBook)
        val newL = mutableStateListOf<Book>()
        newL.addAll(itemsImpl)
        items.postValue(newL)

        println("After")
        println("itemsImpl = $itemsImpl")
        println("items = $items")

    }

    var book by mutableStateOf(Book(0, "", "", 0, false))
        private set

    fun getBook(id: Int) { // TODO: add/remove = viewModelScope.launch(Dispatchers.IO)
        book = itemsImpl.first { it.id == id }
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
        println("Before")
        println("itemsImpl = $itemsImpl")
        println("items = $items")

        val index = itemsImpl.indexOfFirst { it.id == book.id }
        if (index != -1) {
            itemsImpl[index] = book

            println("After")
            println("itemsImpl = $itemsImpl")
            println("items = $items")
        }
    }
}