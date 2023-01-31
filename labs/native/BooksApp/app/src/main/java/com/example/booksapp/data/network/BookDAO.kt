package com.example.booksapp.data.network;


import androidx.room.*

import com.example.booksapp.core.Constraints.Companion.BOOK_TABLE
import com.example.booksapp.domain.Book

import kotlinx.coroutines.flow.Flow;

@Dao
interface BookDAO {
    @Query("SELECT * FROM $BOOK_TABLE")
    fun getAll(): Flow<List<Book>>

    @Query("SELECT * FROM $BOOK_TABLE WHERE id = :id")
    fun get(id: Int): Book

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    fun insert(book: Book)

    @Update
    fun update(book: Book)

    @Query("DELETE FROM $BOOK_TABLE")
    fun deleteAll()

    @Delete
    fun delete(book: Book)
}
