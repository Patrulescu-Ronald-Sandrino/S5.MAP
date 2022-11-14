package com.example.booksapp.view

import androidx.lifecycle.ViewModel
import com.example.booksapp.domain.Book
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class BooksViewModel @Inject constructor() : ViewModel() {

    private val _books: List<Book> = listOf()
    val books: List<Book> get() = _books
}