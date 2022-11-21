package com.example.booksapp.data.repository

import com.example.booksapp.data.network.BookDAO
import com.example.booksapp.domain.Book
import com.example.booksapp.domain.IBookRepository

class BookRepository(
    private val bookDAO: BookDAO
): IBookRepository {
    override fun getBooksFromRoom() = bookDAO.getAll()

    override fun getBookFromRoom(id: Int) = bookDAO.get(id)

    override fun addBookToRoom(book: Book) = bookDAO.insert(book)

    override fun updateBookInRoom(book: Book) = bookDAO.update(book)

    override fun deleteBookFromRoom(book: Book) = bookDAO.delete(book)
}