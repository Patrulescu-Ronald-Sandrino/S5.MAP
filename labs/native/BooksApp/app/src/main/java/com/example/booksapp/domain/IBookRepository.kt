package com.example.booksapp.domain

import kotlinx.coroutines.flow.Flow

interface IBookRepository {
    fun getBooksFromRoom(): Flow<List<Book>>
    fun getBookFromRoom(id: Int): Book
    fun addBookToRoom(book: Book)
    fun updateBookInRoom(book: Book)
    fun deleteBookFromRoom(book: Book)
}